# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/subversion.eclass,v 1.60 2008/05/27 09:49:09 zlin Exp $

# @ECLASS: subversion.eclass
# @MAINTAINER:
# kde-herd
#
# @BLURB: The gitsvn eclass is used to access svn repositories via git.
# @DESCRIPTION:
# Same eclass as subversion eclass but use git svn instead of subversion
# directly.
# Requires EAPI="2"

case ${EAPI} in                                                 
	2) : ;;                                                 
	*) die "No way! EAPI older than 2 is not supported." ;; 
esac  

inherit eutils

ESVN="${ECLASS}"

EXPORT_FUNCTIONS src_unpack pkg_preinst

DESCRIPTION="Based on the ${ECLASS} eclass"


DEPEND=">=dev-util/git-1.6.0[subversion]"

# @ECLASS-VARIABLE: ESVN_STORE_DIR
# @DESCRIPTION:
# subversion sources store directory. Users may override this in /etc/make.conf
[[ -z ${ESVN_STORE_DIR} ]] && ESVN_STORE_DIR="${PORTAGE_ACTUAL_DISTDIR:-${DISTDIR}}/git-src"

# @ECLASS-VARIABLE: ESVN_FETCH_CMD
# @DESCRIPTION:
# subversion checkout command
ESVN_FETCH_CMD="git svn clone"

# @ECLASS-VARIABLE: ESVN_UPDATE_CMD
# @DESCRIPTION:
# subversion update command
ESVN_UPDATE_CMD="git svn rebase"

# @ECLASS-VARIABLE: ESVN_SWITCH_CMD
# @DESCRIPTION:
# subversion switch command
ESVN_SWITCH_CMD="svn switch"

# @ECLASS-VARIABLE: ESVN_OPTIONS
# @DESCRIPTION:
# here we differ against subversion eclass, dont forget you are passing
# variables to git not svn
ESVN_OPTIONS="${ESVN_OPTIONS:-}"

# @ECLASS-VARIABLE: ESVN_REPO_URI
# @DESCRIPTION:
# repository uri
#
# e.g. http://foo/trunk, svn://bar/trunk, svn://bar/branch/foo@1234
#
# supported protocols:
#   http://
#   https://
#   svn://
#   svn+ssh://
#
# to peg to a specific revision, append @REV to the repo's uri
ESVN_REPO_URI="${ESVN_REPO_URI:-}"

# @ECLASS-VARIABLE: ESVN_REVISION
# @DESCRIPTION:
# User configurable revision checkout or update to from the repository
#
# Useful for live svn or trunk svn ebuilds allowing the user to peg
# to a specific revision
#
# WARNING: git tracking, so git version numbering is used
#
# Note: This should never be set in an ebuild!
ESVN_REVISION="${ESVN_REVISION:-}"

# @ECLASS-VARIABLE: ESVN_PROJECT
# @DESCRIPTION:
# project name of your ebuild (= name space)
#
# subversion eclass will check out the subversion repository like:
#
#   ${ESVN_STORE_DIR}/${ESVN_PROJECT}/${ESVN_REPO_URI##*/}
#
# so if you define ESVN_REPO_URI as http://svn.collab.net/repo/svn/trunk or
# http://svn.collab.net/repo/svn/trunk/. and PN is subversion-svn.
# it will check out like:
#
#   ${ESVN_STORE_DIR}/subversion/trunk
#
# this is not used in order to declare the name of the upstream project.
# so that you can declare this like:
#
#   # jakarta commons-loggin
#   ESVN_PROJECT=commons/logging
#
# default: ${PN/-svn}.
ESVN_PROJECT="${ESVN_PROJECT:-${PN/-svn}}"

# @ECLASS-VARIABLE: ESVN_BOOTSTRAP
# @DESCRIPTION:
# bootstrap script or command like autogen.sh or etc..
ESVN_BOOTSTRAP="${ESVN_BOOTSTRAP:-}"

# @ECLASS-VARIABLE: ESVN_PATCHES
# @DESCRIPTION:
# subversion eclass can apply patches in subversion_bootstrap().
# you can use regexp in this variable like *.diff or *.patch or etc.
# NOTE: patches will be applied before ESVN_BOOTSTRAP is processed.
#
# Patches are searched both in ${PWD} and ${FILESDIR}, if not found in either
# location, the installation dies.
ESVN_PATCHES="${ESVN_PATCHES:-}"

# @ECLASS-VARIABLE: ESVN_RESTRICT
# @DESCRIPTION:
# this should be a space delimited list of subversion eclass features to
# restrict.
#   export)
#     don't export the working copy to S.
ESVN_RESTRICT="${ESVN_RESTRICT:-}"

# @ECLASS-VARIABLE: ESVN_OFFLINE
# @DESCRIPTION:
# Set this variable to a non-empty value to disable the automatic updating of
# an svn source tree. This is intended to be set outside the subversion source
# tree by users.
ESVN_OFFLINE="${ESVN_OFFLINE:-${ESCM_OFFLINE}}"

# @ECLASS-VARIABLE: ESVN_UP_FREQ
# @DESCRIPTION:
# Set the minimum number of hours between svn up'ing in any given svn module. This is particularly
# useful for split KDE ebuilds where we want to ensure that all submodules are compiled for the same
# revision. It should also be kept user overrideable.
ESVN_UP_FREQ="${ESVN_UP_FREQ:=}"

# @ECLASS-VARIABLE: ESCM_LOGDIR
# @DESCRIPTION:
# User configuration variable. If set to a path such as e.g. /var/log/scm any
# package inheriting from subversion.eclass will record svn revision to
# ${CATEGORY}/${PN}.log in that path in pkg_preinst. This is not supposed to be
# set by ebuilds/eclasses. It defaults to empty so users need to opt in.
ESCM_LOGDIR="${ESCM_LOGDIR:=}"

# @FUNCTION: subversion_fetch
# @USAGE: [repo_uri] [destination]
# @DESCRIPTION:
# Wrapper function to fetch sources from subversion via svn checkout or svn update,
# depending on whether there is an existing working copy in ${ESVN_STORE_DIR}.
#
# Can take two optional parameters:
#   repo_uri    - a repository URI. default is ESVN_REPO_URI.
#   destination - a check out path in S.
subversion_fetch() {
	local repo_uri="$(subversion__get_repository_uri "${1:-${ESVN_REPO_URI}}")"
	local revision="$(subversion__get_peg_revision "${1:-${ESVN_REPO_URI}}")"
	local S_dest="${2}"

	if [[ -z ${repo_uri} ]]; then
		die "${ESVN}: ESVN_REPO_URI (or specified URI) is empty."
	fi

	[[ -n "${ESVN_REVISION}" ]] && revision="${ESVN_REVISION}"

	# check for the protocol
	local protocol="${repo_uri%%:*}"

	case "${protocol}" in
		http|https)
			if ! built_with_use --missing true -o dev-util/subversion webdav-neon webdav-serf || \
			built_with_use --missing false dev-util/subversion nowebdav ; then
				echo
				eerror "In order to emerge this package, you need to"
				eerror "reinstall Subversion with support for WebDAV."
				eerror "Subversion requires either Neon or Serf to support WebDAV."
				echo
				die "${ESVN}: reinstall Subversion with support for WebDAV."
			fi
			;;
		svn|svn+ssh)
			;;
		*)
			die "${ESVN}: fetch from '${protocol}' is not yet implemented."
			;;
	esac

	addread "/etc/subversion"
	addwrite "${ESVN_STORE_DIR}"

	if [[ ! -d ${ESVN_STORE_DIR} ]]; then
		debug-print "${FUNCNAME}: initial checkout. creating subversion directory"
		mkdir -p "${ESVN_STORE_DIR}" || die "${ESVN}: can't mkdir ${ESVN_STORE_DIR}."
	fi

	cd "${ESVN_STORE_DIR}" || die "${ESVN}: can't chdir to ${ESVN_STORE_DIR}"

	local wc_path="$(subversion__get_wc_path "${repo_uri}")"
	local options="${ESVN_OPTIONS} --config-dir ${ESVN_STORE_DIR}/.subversion"

	[[ -n "${revision}" ]] && options="${options} -r ${revision}"

	if [[ "${ESVN_OPTIONS}" = *-r* ]]; then
		ewarn "\${ESVN_OPTIONS} contains -r, this usage is unsupported. Please"
		ewarn "see \${ESVN_REPO_URI}"
	fi

	debug-print "${FUNCNAME}: wc_path = \"${wc_path}\""
	debug-print "${FUNCNAME}: ESVN_OPTIONS = \"${ESVN_OPTIONS}\""
	debug-print "${FUNCNAME}: options = \"${options}\""

	if [[ ! -d ${wc_path}/.svn ]]; then
		if [[ -n ${ESVN_OFFLINE} ]]; then
			ewarn "ESVN_OFFLINE cannot be used when the there is no existing checkout."
		fi
		# first check out
		einfo "subversion check out start -->"
		einfo "     repository: ${repo_uri}${revision:+@}${revision}"

		debug-print "${FUNCNAME}: ${ESVN_FETCH_CMD} ${options} ${repo_uri}"

		mkdir -p "${ESVN_PROJECT}" || die "${ESVN}: can't mkdir ${ESVN_PROJECT}."
		cd "${ESVN_PROJECT}" || die "${ESVN}: can't chdir to ${ESVN_PROJECT}"
		${ESVN_FETCH_CMD} ${options} "${repo_uri}" || die "${ESVN}: can't fetch to ${wc_path} from ${repo_uri}."

	elif [[ -n ${ESVN_OFFLINE} ]]; then
		subversion_wc_info "${repo_uri}" || die "${ESVN}: unknown problem occurred while accessing working copy."
		if [[ -n ${ESVN_REVISION} && ${ESVN_REVISION} != ${ESVN_WC_REVISION} ]]; then
			die "${ESVN}: You requested off-line updating and revision ${ESVN_REVISION} but only revision ${ESVN_WC_REVISION} is available locally."
		fi
		einfo "Fetching disabled: Using existing repository copy at revision ${ESVN_WC_REVISION}."
	else
		subversion_wc_info "${repo_uri}" || die "${ESVN}: unknown problem occurred while accessing working copy."

		local esvn_up_freq=
		if [[ -n ${ESVN_UP_FREQ} ]]; then
			if [[ -n ${ESVN_UP_FREQ//[[:digit:]]} ]]; then
				die "${ESVN}: ESVN_UP_FREQ must be an integer value corresponding to the minimum number of hours between svn up."
			elif [[ -z $(find "${wc_path}/.svn/entries" -mmin "+$((ESVN_UP_FREQ*60))") ]]; then
				einfo "Fetching disabled since ${ESVN_UP_FREQ} hours has not passed since last update."
				einfo "Using existing repository copy at revision ${ESVN_WC_REVISION}."
				esvn_up_freq=no_update
			fi
		fi

		if [[ -z ${esvn_up_freq} ]]; then
			if [[ ${ESVN_WC_URL} != $(subversion__get_repository_uri "${repo_uri}") ]]; then
				einfo "subversion switch start -->"
				einfo "     old repository: ${ESVN_WC_URL}@${ESVN_WC_REVISION}"
				einfo "     new repository: ${repo_uri}${revision:+@}${revision}"

				debug-print "${FUNCNAME}: ${ESVN_SWITCH_CMD} ${options} ${repo_uri}"

				cd "${wc_path}" || die "${ESVN}: can't chdir to ${wc_path}"
				${ESVN_SWITCH_CMD} ${options} ${repo_uri} || die "${ESVN}: can't update ${wc_path} from ${repo_uri}"
			else
				# update working copy
				einfo "subversion update start -->"
				einfo "     repository: ${repo_uri}${revision:+@}${revision}"

				debug-print "${FUNCNAME}: ${ESVN_UPDATE_CMD} ${options}"

				cd "${wc_path}" || die "${ESVN}: can't chdir to ${wc_path}"
				${ESVN_UPDATE_CMD} ${options} || die "${ESVN}: can't update ${wc_path} from ${repo_uri}."
			fi
		fi
	fi

	einfo "   working copy: ${wc_path}"

	if ! has "export" ${ESVN_RESTRICT}; then
		cd "${wc_path}" || die "${ESVN}: can't chdir to ${wc_path}"

		local S="${S}/${S_dest}"
		mkdir -p "${S}"

		# export to the ${WORKDIR}
		#*  "svn export" has a bug.  see http://bugs.gentoo.org/119236
		#* svn export . "${S}" || die "${ESVN}: can't export to ${S}."
		rsync -rlpgo --exclude=".svn/" . "${S}" || die "${ESVN}: can't export to ${S}."
	fi

	echo
}

# @FUNCTION: subversion_bootstrap
# @DESCRIPTION:
# Apply patches in ${ESVN_PATCHES} and run ${ESVN_BOOTSTRAP} if specified.
subversion_bootstrap() {
	if has "export" ${ESVN_RESTRICT}; then
		return
	fi

	cd "${S}"

	if [[ -n ${ESVN_PATCHES} ]]; then
		einfo "apply patches -->"

		local patch fpatch

		for patch in ${ESVN_PATCHES}; do
			if [[ -f ${patch} ]]; then
				epatch "${patch}"

			else
				for fpatch in ${FILESDIR}/${patch}; do
					if [[ -f ${fpatch} ]]; then
						epatch "${fpatch}"

					else
						die "${ESVN}: ${patch} not found"

					fi
				done

			fi
		done

		echo
	fi

	if [[ -n ${ESVN_BOOTSTRAP} ]]; then
		einfo "begin bootstrap -->"

		if [[ -f ${ESVN_BOOTSTRAP} && -x ${ESVN_BOOTSTRAP} ]]; then
			einfo "   bootstrap with a file: ${ESVN_BOOTSTRAP}"
			eval "./${ESVN_BOOTSTRAP}" || die "${ESVN}: can't execute ESVN_BOOTSTRAP."

		else
			einfo "   bootstrap with command: ${ESVN_BOOTSTRAP}"
			eval "${ESVN_BOOTSTRAP}" || die "${ESVN}: can't eval ESVN_BOOTSTRAP."

		fi
	fi
}

# @FUNCTION: subversion_src_unpack
# @DESCRIPTION:
# default src_unpack. fetch and bootstrap.
subversion_src_unpack() {
	subversion_fetch     || die "${ESVN}: unknown problem occurred in subversion_fetch."
	subversion_bootstrap || die "${ESVN}: unknown problem occurred in subversion_bootstrap."
}

# @FUNCTION: subversion_wc_info
# @USAGE: [repo_uri]
# @RETURN: ESVN_WC_URL, ESVN_WC_ROOT, ESVN_WC_UUID, ESVN_WC_REVISION and ESVN_WC_PATH
# @DESCRIPTION:
# Get svn info for the specified repo_uri. The default repo_uri is ESVN_REPO_URI.
#
# The working copy information on the specified repository URI are set to
# ESVN_WC_* variables.
subversion_wc_info() {
	local repo_uri="$(subversion__get_repository_uri "${1:-${ESVN_REPO_URI}}")"
	local wc_path="$(subversion__get_wc_path "${repo_uri}")"

	debug-print "${FUNCNAME}: repo_uri = ${repo_uri}"
	debug-print "${FUNCNAME}: wc_path = ${wc_path}"

	if [[ ! -d ${wc_path} ]]; then
		return 1
	fi

	export ESVN_WC_URL="$(subversion__svn_info "${wc_path}" "URL")"
	export ESVN_WC_ROOT="$(subversion__svn_info "${wc_path}" "Repository Root")"
	export ESVN_WC_UUID="$(subversion__svn_info "${wc_path}" "Repository UUID")"
	export ESVN_WC_REVISION="$(subversion__svn_info "${wc_path}" "Revision")"
	export ESVN_WC_PATH="${wc_path}"
}

## -- Private Functions

## -- subversion__svn_info() ------------------------------------------------- #
#
# param $1 - a target.
# param $2 - a key name.
#
subversion__svn_info() {
	local target="${1}"
	local key="${2}"

	env LC_ALL=C svn info "${target}" | grep -i "^${key}" | cut -d" " -f2-
}

## -- subversion__get_repository_uri() --------------------------------------- #
#
# param $1 - a repository URI.
subversion__get_repository_uri() {
	 local repo_uri="${1}"

	debug-print "${FUNCNAME}: repo_uri = ${repo_uri}"

	if [[ -z ${repo_uri} ]]; then
		die "${ESVN}: ESVN_REPO_URI (or specified URI) is empty."
	fi

	# delete trailing slash
	if [[ -z ${repo_uri##*/} ]]; then
		repo_uri="${repo_uri%/}"
	fi

	repo_uri="${repo_uri%@*}"

	echo "${repo_uri}"
}

## -- subversion__get_wc_path() ---------------------------------------------- #
#
# param $1 - a repository URI.
subversion__get_wc_path() {
	local repo_uri="$(subversion__get_repository_uri "${1}")"

	debug-print "${FUNCNAME}: repo_uri = ${repo_uri}"

	echo "${ESVN_STORE_DIR}/${ESVN_PROJECT}/${repo_uri##*/}"
}

## -- subversion__get_peg_revision() ----------------------------------------- #
#
# param $1 - a repository URI.
subversion__get_peg_revision() {
	local repo_uri="${1}"

	debug-print "${FUNCNAME}: repo_uri = ${repo_uri}"

	# repo_uri has peg revision ?
	if [[ ${repo_uri} != *@* ]]; then
		debug-print "${FUNCNAME}: repo_uri does not have a peg revision."
	fi

	local peg_rev=
	[[ ${repo_uri} = *@* ]] &&  peg_rev="${repo_uri##*@}"

	debug-print "${FUNCNAME}: peg_rev = ${peg_rev}"

	echo "${peg_rev}"
}

# @FUNCTION: subversion_pkg_preinst
# @USAGE: [repo_uri]
# @DESCRIPTION:
# Log the svn revision of source code. Doing this in pkg_preinst because we
# want the logs to stick around if packages are uninstalled without messing with
# config protection.
subversion_pkg_preinst() {
	local pkgdate=$(date "+%Y%m%d %H:%M:%S")
	subversion_wc_info "${1:-${ESVN_REPO_URI}}"
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
