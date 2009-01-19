# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:
#
# INTRODUCTION:
#     * This subversion.eclass embeds git-svn which can be activated by declaring 'USE_GITSVN=true' in your make.conf file.
#
# TODO:
#     See subversion_pkg_preinst() below.
# 
# GLOBAL SCOPE VARIABLES:
#     ESVN_BOOTSTRAP:
#         * If defined by user, is a command or a path to a script that will be enacted after 
#         * the sources are fetched or updated. see the 'subversion_bootstrap()' function
#     ESVN_FETCH_CMD:
#         * The svn or git-svn command to download the sources for the first time.
#     ESVN_LOG_DIR:
#         * If defined by user, is the directory to store a file that records the current 
#         * revision of the sources.
#     ESVN_OFFLINE:
#         * If defined by user, states wether the user wants the sources updated. Currently 
#         * not enabled for git-svn usage.
#     ESVN_OPTIONS:
#         * Has defaults as well as providing options to user. These are the options passed to
#         * either the 'svn checkout' 'git-svn fetch' commands. See man pages for the commands.
#     ESVN_PATCHES:
#         * If defined by user, states a patch/diff file(s) to be applied to the sources in the 
#         * 'subversion_bootstrap function (see below).
#     ESVN_REPO_URI:
#         * MUST be defined by user. States the uri of the package to be downloaded from the 
#         * remote repository.
#     ESVN_RESTRICT:
#         * If defined by user, provides restrictions to this eclass. Currently only the
#         * 'export' definition is implemented which stops this script from exporting the sources to
#         * the build directory ( ${S} ).
#     ESVN_REVISION:
#         * The revision to download, either defined by the user or automatically caluclated 
#         * to the latest available by this script.
#     ESVN_STORE_DIR:
#         * The defined local directory path for source repositories. Default is 
#         * /usr/portage/distfiles/svn-src or gitsvn-src.
#     ESVN_SWITCH_CMD:
#         * If the uri of the remote repository has changed, applies the 'svn switch' command.
#         * not implemented for git-svn
#     ESVN_UPDATE_CMD:
#         * The svn or git-svn command to update the local repository.
#     ESVN_UP_FREQ:
#         * Prohibits updating the local repository within a number of hours defined by this variable.
#         * Defaults to one hour. Useful when maintaining revision for sets is necessary.
#     ESVN_WC_PATH:
#         * Path to package in local repository. Default may be overridden by user.
#
# FUNCTIONS:
#     subversion_src_unpack()
#         * The function called externally that then calls init, fetch, and bootstrap for either
#         * svn or git-svn depending on whether 'USE_GITSVN=true' is defined prior to call.
#     subversion_init()
#         * Initializes some variables.
#     subversion_init_cont()
#         * Initializes additional variables. Needed because subversion_fetch is permitted to 
#         * (re)define ESVN_REPO_URI.
#     subversion__get_repository_uri()
#         * Used to filter ESVN_REPO_URI appropriately.
#     subversion_get_esvn_up_freq()
#         * Certifies the updating restriction as defined by ESVN_UP_FREQ.
#     subversion_fetch()
#         * Either fetches or updates the sources in the local repo. Svn only.
#     subversion__get_peg_revision()
#         * Derives the revision to fetch/update via the uri if defined as <pkg_uri>@<revision>.
#         * Not implemented for git-svn at this time.
#     subversion_wc_info()
#         * Used internally to get local repository info. Used by svn, not git-svn.
#         * NOTE: This implementation was taken from the old subversion.eclass and needs to 
#         *       be rewritten, badly.
#     subversion__svn_info()
#         * See subversion_wc_info().
#     gitsvn_fetch_cmd()
#         * Either fetches or updates the sources in the local repository. Git-svn only.
#     gitsvn_pkg_rev()
#         * Used by git-svn to get the latest revision to download.
#     gitsvn_externals()
#         * Used by git-svn to fetch or update the svn:externals.
#     subversion_bootstrap()
#         * Used if ESVN_BOOTSTRAP and/or ESVN_PATCHES is defined by user.
#     subversion_pkg_preinst()
#         * Only if called by user and if ESCM_LOGDIR is defined. See ESCM_LOGDIR for info.
#         * TODO: Possibly utilize this function to eliminate unnecessary updates as is currently
#         *       prevalent in all live emerges. Especially true and needed for rebuilding sets.

inherit eutils
EXPORT_FUNCTIONS src_unpack pkg_preinst
DEPEND="net-misc/rsync"
if [[ ${USE_GITSVN} = true ]]; then
    DEPEND="${DEPEND} dev-util/git"
else
    DEPEND="${DEPEND} dev-util/subversion"
fi

subversion_src_unpack() {
    subversion_init || die "${ECLASS}::${FUNCNAME}::${LINENO} ~ "
    subversion_fetch || die "${ECLASS}::${FUNCNAME}::${LINENO} ~ "
    subversion_bootstrap || die "${ECLASS}::${FUNCNAME}::${LINENO} ~ "
}

subversion_init() {
    if [[ ${USE_GITSVN} = true ]]; then
        ESVN_STORE_DIR="${PORTAGE_ACTUAL_DISTDIR:-${DISTDIR}}/gitsvn-src"
        ESVN_FETCH_CMD="gitsvn_fetch_cmd"
        ESVN_UPDATE_CMD="git svn rebase"
    else
        ESVN_STORE_DIR="${PORTAGE_ACTUAL_DISTDIR:-${DISTDIR}}/gitsvn-src"
        ESVN_FETCH_CMD="svn checkout"
        ESVN_UPDATE_CMD="svn update"
        ESVN_SWITCH_CMD="svn switch"
    fi
    [[ ! -d ${ESVN_STORE_DIR} ]] && mkdir -p "${ESVN_STORE_DIR}"
    addwrite "${ESVN_STORE_DIR}"
    [[ -z ${ESVN_REPO_URI} ]] && die "ESVN_REPO_URI must be defined by user of subversion.eclass"
    subversion_init_cont "${ESVN_REPO_URI}"
}

subversion_init_cont() {
    ESVN_REPO_URI="$(subversion__get_repository_uri "${1}")"
    ESVN_WC_PATH="${ESVN_STORE_DIR}/${ESVN_PROJECT}/${ESVN_REPO_URI##*/}"
    ESVN_REVISION="$(subversion__get_peg_revision "${ESVN_REPO_URI}")"
    subversion_wc_info "${ESVN_REPO_URI}"
}

subversion__get_repository_uri() {
    local repo_uri="${1}"
    [[ -z ${repo_uri} ]] && die "${ECLASS}::${FUNCNAME} ~ ESVN_REPO_URI (or specified uri) is empty."
    [[ -z ${repo_uri##*/} ]] && repo_uri="${repo_uri%/}"
    repo_uri="${repo_uri%@*}"
    echo "${repo_uri}"
}

subversion_get_esvn_up_freq(){
    local esvn_up_freq=
    if [[ -n ${ESVN_UP_FREQ} ]]; then
        [[ -n ${ESVN_UP_FREQ//[[:digit:]]} ]] && die "${ECLASS}::${FUNCNAME} ~ must be an integer value corresponding to the minimum number of hours between svn up."
        elif [[ -z $(find "${ESVN_WC_PATH}/.svn/entries" -mmin "+$((ESVN_UP_FREQ*60))") ]]; then
        einfo "Fetching disabled since ${ESVN_UP_FREQ} hours has not passed since last update."
        einfo "Using existing repository copy at revision ${ESVN_WC_REVISION}."
        esvn_up_freq=no_update
    fi
    echo $esvn_up_freq
}

subversion_fetch() {
    local protocol options
    if [[ -n "${1}" ]]; then
        subversion_init_cont "${1}"
    fi
    [[ -n "${2}" ]] && die "A second argument to ${FUNCNAME} is not accepted."
    if [[ ${USE_GITSVN} != true ]]; then
        protocol="${ESVN_REPO_URI%%:*}"
        case "${protocol}" in
            http|https)
                if ! build_with_use --missing true -o dev-util/subversion webdav-neon webdav-serf || built_with_use --missing false dev-util/subversion nowebdav; then
                    echo
                    eerror "In order to emerge this package, you need to"
                    eerror "reinstall Subversion with support for WebDAV."
                    eerror "Subversion requires either Neon or Serf to support WebDAV."
                    echo
                    die "${ECLASS}::${FUNCNAME} ~ reinstall Subverion with support for WebDAV."
                fi
                ;;
            svn|svn+ssh)
                ;;
            *)
                die "${ECLASS}::${FUNCNAME} ~ fetch from '${protocol}' is not yet implemented."
                ;;
        esac
        addread "/etc/subversion"
        ESVN_OPTIONS="${ESVN_OPTIONS} --config-dir ${ESVN_STORE_DIR}/.subversion"
        [[ -n "${ESVN_REVISION}" ]] && ESVN_OPTIONS="${ESVN_OPTIONS} -r ${ESVN_REVISION}"
        if [[ "${ESVN_OPTIONS}" = *-r* ]]; then
            ewarn "\${ESVN_OPTIONS} contains -r, this usage is unsupported. Please"
            ewarn "see \${ESVN_REPO_URI}"
        fi
        if [[ ! -d ${ESVN_WC_PATH}/.svn ]]; then
            mkdir -p "${ESVN_WC_PATH}" || die "${FUNCNAME} ~ couldn't mkdir ${$ESVN_WC_PATH}"
            cd "${ESVN_WC_PATH}"
            ${ESVN_FETCH_CMD} ${ESVN_OPTIONS} "${ESVN_REPO_URI}"
        elif [[ -n ${ESVN_OFFLINE} ]]; then
            if [[ -n ${ESVN_REVISION} && ${ESVN_REVISION} != ${ESVN_WC_REVISION} ]]; then
                die "${ECLASS}::${FUNCNAME} ~ You requested off-line updating and revision ${ESVN_REVISION} but only revision ${ESVN_WC_REVISION} is available locally."
            fi
        else
            local esvn_up_freq="$(subversion_get_esvn_up_freq)"
        fi
        if [[ -z ${esvn_up_freq} ]]; then
            if [[ ${ESVN_WC_URL} != "${ESVN_REPO_URI}" ]]; then
                einfo "subversion switch start -->"
                einfo "     old repository: ${ESVN_WC_URL}@${ESVN_WC_REVISION}"
                einfo "     new repository: ${ESVN_REPO_URI}${revision:+@}${revision}"
                ${ESVN_SWITCH_CMD} ${ESVN_OPTIONS} ${ESVN_REPO_URI}
            else
                einfo "subversion update start -->"
                einfo "     repository: ${ESVN_REPO_URI}${ESVN_REVISION:+@}${ESVN_REVISION}"
                cd "${ESVN_WC_PATH}"
                ${ESVN_UPDATE_CMD} ${ESVN_OPTIONS}
            fi
        fi
    else                                            # USE_GITSVN = true
        if [[ ! -d ${ESVN_WC_PATH}/.git ]]; then
            mkdir -p "${ESVN_WC_PATH}" || die "${FUNCNAME} ~ couldn't mkdir ${ESVN_WC_PATH}"
            cd "${ESVN_WC_PATH}" || die "${FUNCNAME} ~ couldn't cd to ${ESVN_WC_PATH}"
            local pkg_rev="$(gitsvn_pkg_rev "${ESVN_REPO_URI}")"
            ${ESVN_FETCH_CMD} "${ESVN_REPO_URI}" "${pkg_rev}"
            gitsvn_externals || die "gitsvn_externals failed."
        elif [[ -n ${ESVN_OFFLINE} ]]; then
            die "${ECLASS}::${FUNCNAME} ~ ESVN_OFFLINE is not yet implemented."
        else
            local esvn_up_freq=
            if [[ -n ${ESVN_UP_FREQ} ]]; then
                [[ -n ${ESVN_UP_FREQ//[[:digit:]]} ]] && die "${ECLASS}::${FUNCNAME} ~ ESVN_UP_FREQ must be an integer value corresponding to the minimum number of hours between svn up."
                local gitlog gitlog_arr rel_time
                gitlog=$(git log --date=relative)
                gitlog_arr=(${gitlog%%ago*})
                rel_time=${gitlog_arr[@]:(-1)}
                [[ ${rel_time} = "seconds" || ${rel_time} = "minutes" ]] && esvn_up_freq=no_update
            fi
            if [[ -z ${esvn_up_freq} ]]; then
                cd "${ESVN_WC_PATH}" || die "${ECLASS}::${FUNCNAME}::${LINENO} ~ "
                ${ESVN_UPDATE_CMD}
                gitsvn_externals "update" || die "${ECLASS}::${FUNCNAME}::${LINENO} ~ "
            fi
        fi
    fi
    if ! has "export" ${ESVN_RESTRICT}; then
        cd "${wc_path}"
        local S="${S}/${S_dest}"
        mkdir -p "${S}" || die "${ECLASS}::${FUNCNAME}::${LINENO} ~ "
        rsync -rlpgo --exclude=".svn/" . "${S}" 
    fi        
}
            
subversion__get_peg_revision() {
    local peg_rev
    local ESVN_REPO_URI="${1}"
    [[ ${ESVN_REPO_URI} = *@* ]] && peg_rev="${ESVN_REPO_URI##*@}"
    echo "${peg_rev}"
}

subversion_wc_info() {
    local ESVN_REPO_URI wc_path
    ESVN_REPO_URI="$(subversion__get_reposiory_uri "${1:-${ESVN_REPO_URI}}")"
    wc_path="$(subversion__get_wc_path "${ESVN_REPO_URI}")"
    [[ ! -d ${wc_path} ]] && return 1
    export ESVN_WC_URL="$(subversion__svn_info "${wc_path}" "URL")"
    export ESVN_WC_ROOT="$(subversion__svn_info "${wc_path}" "Repository Root")"
    export ESVN_WC_UUID="$(subversion__svn_info "${wc_path}" "Repository UUID")"
    export ESVN_WC_REVISION="$(subversion__svn_info "${wc_path}" "Revision")"
    export ESVN_WC_PATH="${wc_path}"
}

subversion__svn_info() {
    local target key
    target="${1}"
    key="${2}"
    env LC_ALL=C svn info "${target}" | grep -i "^${key}" | cut -d" " -f2-
}

gitsvn_fetch_cmd() {
    git svn init "${1}" || die "'git svn init' failed"
    git svn fetch -r"${2}" || die "'git svn fetch' failed"
}

gitsvn_pkg_rev() {
    local svninfo_arr rev
    svninfo_arr=($(svn info "${1}"))
    for i in $(seq 0 $((${#svninfo_arr[@]} - 1))); do
        case "${svninfo_arr[i]}" in
            Rev:)
                rev=${svninfo_arr[i+1]}
                ;;
            *)
                ;;
        esac
    done
    echo "${rev}"
}

gitsvn_externals() {
    local externals_uri rel_path externals_path pkg_rev externals_dir
    ESVN_EXTERNALS=$(grep "svn:externals" ${ESVN_WC_PATH}/.git/svn/git-svn/unhandled.log | grep ://)
    if [[ -n "${ESVN_EXTERNALS}" ]]; then
        externals_uri="${ESVN_EXTERNALS##*\%20}"
        externals_uri="${externals_uri%\%0A*}"
        rel_path="${ESVN_EXTERNALS##*+dir_prop: }"
        rel_path="${rel_path%% svn:externals*}"
        [[ -z ${externals_uri##*/} ]] && externals_uri="${externals_uri%/}"
        externals_dir="${externals_uri##*/}"
        externals_path="${ESVN_WC_PATH}/${rel_path}/${externals_dir}"
        pkg_rev=$(gitsvn_pkg_rev "${externals_uri}")
        if [[ ! -d ${externals_path}/.git ]]; then
            mkdir -p "${externals_path}" || die "${ECLASS}::${FUNCNAME}::${LINENO} ~"
            cd "${externals_path}" || die "${ECLASS}::${FUNCNAME}::${LINENO} ~"
            ${ESVN_FETCH_CMD} "${externals_uri}" "${pkg_rev}"
        else
            cd "${externals_path}" || die einfo "${ECLASS}::${FUNCNAME}::${LINENO} ~"
            ${ESVN_UPDATE_CMD}
        fi
    fi
}
        
subversion_bootstrap() {
    if has "export" ${ESVN_RESTRICT}; then
        return
    fi
    cd "${S}"
    if [[ -n ${ESVN_PATCHES} ]]; then
        local patch fpatch
        for patch in ${ESVN_PATCHES}; do
            if [[ -f ${patch} ]]; then
                epatch "${patch}"
            else
                for fpatch in ${FILESDIR}/${patch}; do
                    if [[ -f ${fpatch} ]]; then
                        epatch "${patch}"
                    else
                        die "${ECLASS}::${FUNCNAME} ~ ${patch} not found"
                    fi
                done
            fi
        done
        echo
    fi
    if [[ -n ${ESVN_BOOTSTRAP} ]]; then
        if [[ -f ${ESVN_BOOTSTRAP} && -x ${ESVN_BOOTSTRAP} ]]; then
            eval "./${ESVN_BOOTSTRAP}"
        else
            eval "${ESVN_BOOTSTRAP}"
        fi
    fi
}

subversion_pkg_preinst() {
    local pkgdate=$(date "+%Y%m%d %H:%M:%S")
    if [[ -n ${ESCM_LOGDIR} ]]; then
        local dir="${ROOT}/${ESCM_LOGDIR}/${CATEGORY}"
        if [[ ! -d ${dir} ]]; then
            mkdir -p "${dir}" || \
                eerror "Failed to create '${dir}' for logging svn revision to '${PORTDIR_SCM}'"
        fi
        local logmessage="svn: ${pkgdate} - ${PF}:${SLOT} was merged at revision ${ESVN_WC_REVISION}"
        if [[ -d ${dir} ]]; then
            echo "${logmessage}" >> "${dir}/${PN}.log"
        else
            eerror "Could not log the message '${logmessage}' to '${dir}/${PN}.log'"
        fi
    fi
}



























