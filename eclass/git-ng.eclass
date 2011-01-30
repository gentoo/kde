# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# @ECLASS: git-ng.eclass
# @MAINTAINER:
# Tomas Chvatal <scarabeus@gentoo.org>
# @BLURB: This eclass provides functions for fetch and unpack git repositories
# @DESCRIPTION:
# Tadydaydya WRITEME
inherit eutils

EXPORTED_FUNCTIONS="src_unpack"
case "${EAPI:-0}" in
	4|3) ;;
	*) die "EAPI=${EAPI} is not supported" ;;
esac
EXPORT_FUNCTIONS ${EXPORTED_FUNCTIONS}

DEPEND="dev-vcs/git"

# This static variable is for storing the data in WORKDIR.
# Sometimes we might want to redefine S.
SOURCE="${WORKDIR}/${PN}-${PV}"

# Gitstat command used to get differences in sources
ESCM_DIFFSTAT_CMD="git --no-pager diff --stat"

# @FUNCTION: git-ng_init_variables
# @DESCRIPTION:
# Internal function initializing all git variables
git-ng_init_variables() {
	# @ECLASS-VARIABLE: ESCM_QUIET
	# @DESCRIPTION:
	# Set to non-empty value to supress some eclass messages.
	: ${ESCM_QUIET:=${ESCM_QUIET}}

	# @ECLASS-VARIABLE: ESCM_STORE_DIR
	# @DESCRIPTION:
	# Storage directory for git sources.
	# Can be redefined.
	: ${ESCM_STORE_DIR:="${PORTAGE_ACTUAL_DISTDIR-${DISTDIR}}/egit-src"}

	# @ECLASS-VARIABLE: ESCM_HAS_SUBMODULES
	# @DESCRIPTION:
	# Set this to non-empty value to enable submodule support (slower).
	: ${ESCM_HAS_SUBMODULES:=}

	# @ECLASS-VARIABLE: ESCM_FETCH_CMD
	# @DESCRIPTION:
	# Command for cloning the repository.
	: ${ESCM_FETCH_CMD:="git clone"}

	# @ECLASS-VARIABLE: ESCM_UPDATE_CMD
	# @DESCRIPTION:
	# Git fetch command.
	if [[ -n ${ESCM_HAS_SUBMODULES} ]]; then
		ESCM_UPDATE_CMD="git pull -f -u"
	else
		ESCM_UPDATE_CMD="git fetch -t -f -u"
	fi

	# @ECLASS-VARIABLE: ESCM_OPTIONS
	# @DESCRIPTION:
	# This variable value is passed to clone and fetch.
	: ${ESCM_OPTIONS:=}

	# @ECLASS-VARIABLE: ESCM_MASTER
	# @DESCRIPTION:
	# Variable for specifying master branch.
	# Usefull when upstream don't have master branch.
	: ${ESCM_MASTER:=master}

	# @ECLASS-VARIABLE: ESCM_REPO_URI
	# @DESCRIPTION:
	# URI for the repository
	# e.g. http://foo, git://bar
	# Supported protocols:
	#   http://
	#   https://
	#   git://
	#   git+ssh://
	#   rsync://
	#   ssh://
	eval X="\$${PN//[-+]/_}_LIVE_REPO"
	if [[ ${X} = "" ]]; then
		: ${ESCM_REPO_URI:=}
	else
		ESCM_REPO_URI="${X}"
	fi
	[[ -z ${ESCM_REPO_URI} ]] && die "ESCM_REPO_URI must have some value."
	if [[ -z ${ESCM_REPO_URI%%:*} ]] ; then
		case ${ESCM_REPO_URI%%:*} in
			git*|http|https|rsync|ssh) ;;
			*) die "Protocol for fetch from "${ESCM_REPO_URI%:*}" is not yet implemented in eclass." ;;
		esac
	fi

	# @ECLASS-VARIABLE: ESCM_OFFLINE
	# @DESCRIPTION:
	# Set this variable to a non-empty value to disable the automatic updating of
	# an GIT source tree. This is intended to be set outside the git source
	# tree by users.
	: ${ESCM_OFFLINE:=${ESCM_OFFLINE}}

	# @ECLASS-VARIABLE: ESCM_BRANCH
	# @DESCRIPTION:
	# git eclass can fetch any branch in git_fetch().
	eval X="\$${PN//[-+]/_}_LIVE_BRANCH"
	if [[ "${X}" = "" ]]; then
		: ${ESCM_BRANCH:=master}
	else
		ESCM_BRANCH="${X}"
	fi

	# @ECLASS-VARIABLE: ESCM_COMMIT
	# @DESCRIPTION:
	# git eclass can checkout any commit.
	eval X="\$${PN//[-+]/_}_LIVE_COMMIT"
	if [[ "${X}" = "" ]]; then
		: ${ESCM_COMMIT:=${ESCM_BRANCH}}
	else
		ESCM_COMMIT="${X}"
	fi

	# @ECLASS-VARIABLE: ESCM_REPACK
	# @DESCRIPTION:
	# Set to non-empty value to repack objects to save disk space. However this can
	# take a REALLY LONG time with VERY big repositories.
	: ${ESCM_REPACK:=}

	# @ECLASS-VARIABLE: ESCM_PRUNE
	# @DESCRIPTION:
	# Set to non-empty value to prune loose objects on each fetch. This is useful
	# if upstream rewinds and rebases branches often.
	: ${ESCM_PRUNE:=}

}

# @FUNCTION: git-ng_submodules
# @DESCRIPTION:
# Internal function wrapping the submodule initialisation and update
git-ng_submodules() {
	if [[ -n ${ESCM_HAS_SUBMODULES} ]]; then
		debug-print "git submodule init"
		git submodule init || die "Git submodule initialisation failed"
		debug-print "git submodule update"
		git submodule update || die "Git submodule update failed"
	fi
}

# @FUNCTION: git-ng_branch
# @DESCRIPTION:
# Internal function that changes branch for the repo based on ESCM_COMMIT and
# ESCM_BRANCH variables.
git-ng_branch() {
	local branchname=branch-${ESCM_BRANCH} src=origin/${ESCM_BRANCH}
	if [[ "${ESCM_COMMIT}" != "${ESCM_BRANCH}" ]]; then
		branchname=tree-${ESCM_COMMIT}
		src=${ESCM_COMMIT}
	fi
	debug-print "git checkout -b ${branchname} ${src}"
	git checkout -b ${branchname} ${src} || die "Changing the branch failed"

	unset branchname src
}

# @FUNCTION: git-ng_gc
# @DESCRIPTION:
# Run garbage collector on checked out tree
git-ng_gc() {
	pushd "${GIT_DIR}" &> /dev/null
	if [[ -n ${ESCM_REPACK} || -n ${ESCM_PRUNE} ]]; then
		ebegin "Garbage collecting the repository"
		local args
		[[ -n ${ESCM_PRUNE} ]] && args='--prune'
		git gc ${args}
		eend $?
	fi
	popd &> /dev/null
}


# @FUNCTION: git_fetch
# @DESCRIPTION:
# Gets repository from ESCM_REPO_URI and store it in specified ESCM_STORE_DIR
git-ng_fetch() {
	debug-print-function ${FUNCNAME} "$@"

	local ESCM_CLONE_DIR oldsha1 cursha1 extra_clone_opts upstream_branch
	[[ -z ${ESCM_HAS_SUBMODULES} ]] && export GIT_DIR

	# choose if user wants elog or just einfo.
	if [[ -n ${ESCM_QUIET} ]]; then
		elogcmd="einfo"
	else
		elogcmd="elog"
	fi

	# initial clone, we have to create master git storage directory and play
	# nicely with sandbox
	if [[ ! -d ${ESCM_STORE_DIR} ]] ; then
		debug-print "${FUNCNAME}: initial clone. creating git directory"
		addwrite ${PORTAGE_ACTUAL_DISTDIR-${DISTDIR}}
		mkdir -p "${ESCM_STORE_DIR}" \
			|| die "${ESCM}: can't mkdir ${ESCM_STORE_DIR}."
	fi

	cd -P "${ESCM_STORE_DIR}" || die "Can't chdir to ${ESCM_STORE_DIR}"
	ESCM_STORE_DIR=${PWD}
	# allow writing into ESCM_STORE_DIR
	addwrite "${ESCM_STORE_DIR}"
	# calculate the proper store dir for data
	[[ -z ${ESCM_REPO_URI##*/} ]] && ESCM_REPO_URI="${ESCM_REPO_URI%/}"
	ESCM_CLONE_DIR="${ESCM_REPO_URI##*/}"
	GIT_DIR="${ESCM_STORE_DIR}/${ESCM_CLONE_DIR}"
	debug-print "${FUNCNAME}: Storing the repo into \"${GIT_DIR}\"."

	# we can not jump between using and not using SUBMODULES so we need to
	# refetch the source when needed
	if [[ -n ${ESCM_HAS_SUBMODULES} && -d ${GIT_DIR} && ! -d ${GIT_DIR}/.git ]]; then
		rm -rf "${GIT_DIR}"
		einfo "The ${ESCM_CLONE_DIR} was bare copy. Refetching."
	fi
	if [[ -z ${ESCM_HAS_SUBMODULES} && -d ${GIT_DIR} && -d ${GIT_DIR}/.git ]]; then
		rm -rf "${GIT_DIR}"
		einfo "The ${ESCM_CLONE_DIR} was not a bare copy. Refetching."
	fi

	if [[ -n ${ESCM_HAS_SUBMODULES} ]]; then
		upstream_branch=origin/${ESCM_BRANCH}
	else
		upstream_branch=${ESCM_BRANCH}
		extra_clone_opts=--bare
	fi

	if [[ ! -d ${GIT_DIR} ]] ; then
		# first clone
		${elogcmd} "GIT NEW clone -->"
		${elogcmd} "   repository: 		${ESCM_REPO_URI}"

		debug-print "${ESCM_FETCH_CMD} ${extra_clone_opts} ${ESCM_OPTIONS} \"${ESCM_REPO_URI}\" ${GIT_DIR}"
		${ESCM_FETCH_CMD} ${extra_clone_opts} ${ESCM_OPTIONS} "${ESCM_REPO_URI}" ${GIT_DIR} \
			|| die "Can't fetch from ${ESCM_REPO_URI}."

		pushd "${GIT_DIR}" &> /dev/null
		cursha1=$(git rev-parse ${upstream_branch})
		${elogcmd} "   at the commit:		${cursha1}"

		git-ng_submodules
		popd &> /dev/null
	elif [[ -n ${ESCM_OFFLINE} ]] ; then
		pushd "${GIT_DIR}" &> /dev/null
		cursha1=$(git rev-parse ${upstream_branch})
		${elogcmd} "GIT offline update -->"
		${elogcmd} "   repository: 		${ESCM_REPO_URI}"
		${elogcmd} "   at the commit:		${cursha1}"
		popd &> /dev/null
	else
		pushd "${GIT_DIR}" &> /dev/null
		# Git urls might change, so unconditionally set it here
		git config remote.origin.url "${ESCM_REPO_URI}"

		# fetch updates
		${elogcmd} "GIT update -->"
		${elogcmd} "   repository: 		${ESCM_REPO_URI}"

		oldsha1=$(git rev-parse ${upstream_branch})

		if [[ -n ${ESCM_HAS_SUBMODULES} ]] || [[ -n ${ESCM_HAS_WORKDIR} ]]; then
			debug-print "${ESCM_UPDATE_CMD} ${ESCM_OPTIONS}"
			# fix branching
			git checkout ${ESCM_MASTER}
			for x in $(git branch |grep -v "* ${ESCM_MASTER}" |tr '\n' ' '); do
				git branch -D ${x}
			done
			${ESCM_UPDATE_CMD} ${ESCM_OPTIONS} \
				|| die "Can't update from ${ESCM_REPO_URI}."
		else
			debug-print "${ESCM_UPDATE_CMD} ${ESCM_OPTIONS} origin ${ESCM_BRANCH}:${ESCM_BRANCH}"
			${ESCM_UPDATE_CMD} ${ESCM_OPTIONS} origin ${ESCM_BRANCH}:${ESCM_BRANCH} \
				|| die "Can't update from ${ESCM_REPO_URI}."
		fi

		git-ng_submodules
		cursha1=$(git rev-parse ${upstream_branch})

		# write out message based on the revisions
		if [[ "${oldsha1}" != "${cursha1}" ]]; then
			${elogcmd} "   updating from commit:	${oldsha1}"
			${elogcmd} "   to commit:		${cursha1}"
		else
			${elogcmd} "   at the commit: 		${cursha1}"
		fi
		${ESCM_DIFFSTAT_CMD} ${oldsha1}..${upstream_branch}
		popd &> /dev/null
	fi

	git-ng_gc

	# export the git version
	export ESCM_VERSION="${cursha1}"

	# log the repo state
	[[ "${ESCM_COMMIT}" != "${ESCM_BRANCH}" ]] && ${elogcmd} "   commit:			${ESCM_COMMIT}"
	${elogcmd} "   branch: 			${ESCM_BRANCH}"
	${elogcmd} "   storage directory: 	\"${GIT_DIR}\""

	# move the data to workdir
	if [[ -n ${ESCM_HAS_SUBMODULES} ]]; then
		pushd "${GIT_DIR}" &> /dev/null
		debug-print "rsync -rlpgo . \"${SOURCE}\""
		rsync -rlpgo . "${SOURCE}" || die "Sync of git data to \"${SOURCE}\" failed"
		popd &> /dev/null
	else
		unset GIT_DIR
		debug-print "git clone -l -s -n \"${ESCM_STORE_DIR}/${ESCM_CLONE_DIR}\" \"${SOURCE}\""
		git clone -l -s -n "${ESCM_STORE_DIR}/${ESCM_CLONE_DIR}" "${SOURCE}" || die "Sync of git data to \"${SOURCE}\" failed"
	fi

	pushd "${SOURCE}" &> /dev/null
	git-ng_branch
	# submodules always reqire net (thanks to branches changing)
	[[ -z ${ESCM_OFFLINE} ]] && git-ng_submodules
	popd &> /dev/null

	echo ">>> Unpacked to ${SOURCE}"
}

# @FUNCTION: git_bootstrap
# @DESCRIPTION:
# Runs bootstrap command on unpacked source.
git-ng_bootstrap() {
	debug-print-function ${FUNCNAME} "$@"

	# @ECLASS_VARIABLE: ESCM_BOOTSTRAP
	# @DESCRIPTION:
	# Command to be executed after checkout and clone of the specified
	# repository.
	# enviroment the package will fail if there is no update, thus in
	# combination with --keep-going it would lead in not-updating
	# pakcages that are up-to-date.
	if [[ -n ${ESCM_BOOTSTRAP} ]] ; then
		pushd "${SOURCE}" > /dev/null
		einfo "Starting bootstrap"

		if [[ -f ${ESCM_BOOTSTRAP} ]]; then
			# we have file in the repo which we should execute
			debug-print "$FUNCNAME: bootstraping with file \"${ESCM_BOOTSTRAP}\""

			if [[ -x ${ESCM_BOOTSTRAP} ]]; then
				eval "./${ESCM_BOOTSTRAP}" \
					|| die "bootstrap script failed"
			else
				eerror "\"${ESCM_BOOTSTRAP}\" is not executable."
				eerror "Report upstream, or bug ebuild maintainer to remove bootstrap command."
				die "\"${ESCM_BOOTSTRAP}\" is not executable."
			fi
		else
			# we execute some system command
			debug-print "$FUNCNAME: bootstraping with commands \"${ESCM_BOOTSTRAP}\""

			eval "${ESCM_BOOTSTRAP}" \
				|| die "bootstrap commands failed."
		fi

		einfo "Bootstrap finished"
		popd > /dev/null
	fi
}

# @FUNCTION: git-ng_src_unpack
# @DESCRIPTION:
# src_upack function
git-ng_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

	git-ng_init_variables
	git-ng_fetch $@
	git-ng_bootstrap
}
