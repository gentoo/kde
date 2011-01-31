# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# @ECLASS: git-ng.eclass
# @MAINTAINER:
# Tomas Chvatal <scarabeus@gentoo.org>
# @BLURB: This eclass provides functions for fetch and unpack git repositories
# @DESCRIPTION:
# Eclass for easing maitenance of live ebuilds using git as remote repositories.
# Eclass support working with git submodules and branching.
# revision 
inherit eutils

# This eclass support all EAPIs
EXPORT_FUNCTIONS src_unpack

DEPEND="dev-vcs/git"

# This static variable is for storing the data in WORKDIR.
# Sometimes we might want to redefine S.
SOURCE="${WORKDIR}/${PN}-${PV}"

# @FUNCTION: git-ng_init_variables
# @DESCRIPTION:
# Internal function initializing all git variables.
# We define it in function scope so user can define
# all the variables before and after inherit.
git-ng_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	# @ECLASS-VARIABLE: ESCM_STORE_DIR
	# @DESCRIPTION:
	# Storage directory for git sources.
	# Can be redefined.
	: ${ESCM_STORE_DIR:="${PORTAGE_ACTUAL_DISTDIR-${DISTDIR}}/egit-src"}

	# @ECLASS-VARIABLE: EGIT_HAS_SUBMODULES
	# @DESCRIPTION:
	# Set this to non-empty value to enable submodule support (slower).
	: ${EGIT_HAS_SUBMODULES:=}

	# @ECLASS-VARIABLE: ESCM_FETCH_CMD
	# @DESCRIPTION:
	# Command for cloning the repository.
	: ${ESCM_FETCH_CMD:="git clone"}

	# @ECLASS-VARIABLE: ESCM_UPDATE_CMD
	# @DESCRIPTION:
	# Git fetch command.
	if [[ -n ${EGIT_HAS_SUBMODULES} ]]; then
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
		: ${ESCM_BRANCH:=${ESCM_MASTER}}
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

	# @ECLASS-VARIABLE: EGIT_REPACK
	# @DESCRIPTION:
	# Set to non-empty value to repack objects to save disk space. However this can
	# take a REALLY LONG time with VERY big repositories.
	: ${EGIT_REPACK:=}

	# @ECLASS-VARIABLE: EGIT_PRUNE
	# @DESCRIPTION:
	# Set to non-empty value to prune loose objects on each fetch. This is useful
	# if upstream rewinds and rebases branches often.
	: ${EGIT_PRUNE:=}

}

# @FUNCTION: git-ng_submodules
# @DESCRIPTION:
# Internal function wrapping the submodule initialisation and update
git-ng_submodules() {
	debug-print-function ${FUNCNAME} "$@"

	# for submodules operations we need to be online
	if [[ -z ${ESCM_OFFLINE} && -n ${EGIT_HAS_SUBMODULES} ]]; then
		debug-print "${FUNCNAME}: git submodule init"
		git submodule init || die "Git submodule initialisation failed"
		debug-print "${FUNCNAME}: git submodule sync"
		git submodule sync
		debug-print "${FUNCNAME}: git submodule update"
		git submodule update || die "Git submodule update failed"
	fi
}

# @FUNCTION: git-ng_branch
# @DESCRIPTION:
# Internal function that changes branch for the repo based on ESCM_COMMIT and
# ESCM_BRANCH variables.
git-ng_branch() {
	debug-print-function ${FUNCNAME} "$@"

	local branchname=branch-${ESCM_BRANCH} src=origin/${ESCM_BRANCH}
	if [[ "${ESCM_COMMIT}" != "${ESCM_BRANCH}" ]]; then
		branchname=tree-${ESCM_COMMIT}
		src=${ESCM_COMMIT}
	fi
	debug-print "${FUNCNAME}: git checkout -b ${branchname} ${src}"
	git checkout -b ${branchname} ${src} || die "Changing the branch failed"

	unset branchname src
}

# @FUNCTION: git-ng_gc
# @DESCRIPTION:
# Run garbage collector on checked out tree.
git-ng_gc() {
	debug-print-function ${FUNCNAME} "$@"

	pushd "${GIT_DIR}" &> /dev/null
	if [[ -n ${EGIT_REPACK} || -n ${EGIT_PRUNE} ]]; then
		ebegin "Garbage collecting the repository"
		local args
		[[ -n ${EGIT_PRUNE} ]] && args='--prune'
		git gc ${args}
		eend $?
	fi
	popd &> /dev/null
}

# @FUNCTION: git-ng_prepare_storedir
# @DESCRIPTION:
# Prepare directory where we are going to store SCM repository.
git-ng_prepare_storedir() {
	debug-print-function ${FUNCNAME} "$@"

	local clone_dir

	# initial clone, we have to create master git storage directory and play
	# nicely with sandbox
	if [[ ! -d ${ESCM_STORE_DIR} ]] ; then
		debug-print "${FUNCNAME}: Creating git main storage directory"
		addwrite ${PORTAGE_ACTUAL_DISTDIR-${DISTDIR}}
		mkdir -p "${ESCM_STORE_DIR}" \
			|| die "${FUNCNAME}: can't mkdir ${ESCM_STORE_DIR}."
	fi

	cd -P "${ESCM_STORE_DIR}" || die "${FUNCNAME}:  can't chdir to ${ESCM_STORE_DIR}"
	# allow writing into ESCM_STORE_DIR
	addwrite "${ESCM_STORE_DIR}"
	# calculate the proper store dir for data
	[[ -z ${ESCM_REPO_URI##*/} ]] && ESCM_REPO_URI="${ESCM_REPO_URI%/}"
	clone_dir="${ESCM_REPO_URI##*/}"
	export GIT_DIR="${ESCM_STORE_DIR}/${clone_dir}"
	debug-print "${FUNCNAME}: Storing the repo into \"${GIT_DIR}\"."

	# we can not jump between using and not using SUBMODULES so we need to
	# refetch the source when needed
	if [[ -n ${EGIT_HAS_SUBMODULES} && -d ${GIT_DIR} && ! -d ${GIT_DIR}/.git ]]; then
		debug-print "${FUNCNAME}: \"${clone_dir}\" was bare copy removing..."
		rm -rf "${GIT_DIR}"
	fi
	if [[ -z ${EGIT_HAS_SUBMODULES} && -d ${GIT_DIR} && -d ${GIT_DIR}/.git ]]; then
		debug-print "${FUNCNAME}: \"${clone_dir}\" was not copy removing..."
		rm -rf "${GIT_DIR}"
	fi
}

# @FUNCTION: git-ng_move_source
# @DESCRIPTION:
# Move the sources from the GIT_DIR to SOURCE dir.
git-ng_move_source() {
	if [[ -n ${ESCM_HAS_SUBMODULES} ]]; then
		pushd "${GIT_DIR}" &> /dev/null
		debug-print "rsync -rlpgo . \"${SOURCE}\""
		rsync -rlpgo . "${SOURCE}" || die "Sync of git data to \"${SOURCE}\" failed"
		popd &> /dev/null
	else
		debug-print "git clone -l -s -n \"${GIT_DIR}\" \"${SOURCE}\""
		git clone -l -s -n "${GIT_DIR}" "${SOURCE}" || die "Sync of git data to \"${SOURCE}\" failed"
	fi
}


# @FUNCTION: git-ng_fetch
# @DESCRIPTION:
# Gets repository from ESCM_REPO_URI and store it in specified ESCM_STORE_DIR.
git-ng_fetch() {
	debug-print-function ${FUNCNAME} "$@"

	local oldsha1 cursha1 extra_clone_opts upstream_branch

	git-ng_prepare_storedir

	if [[ -n ${EGIT_HAS_SUBMODULES} ]]; then
		upstream_branch=origin/${ESCM_BRANCH}
	else
		upstream_branch=${ESCM_BRANCH}
		extra_clone_opts="--bare"
	fi

	if [[ ! -d ${GIT_DIR} ]] ; then
		# first clone
		einfo "GIT NEW clone -->"
		einfo "   repository: 		${ESCM_REPO_URI}"

		debug-print "${ESCM_FETCH_CMD} ${extra_clone_opts} ${ESCM_OPTIONS} \"${ESCM_REPO_URI}\" ${GIT_DIR}"
		${ESCM_FETCH_CMD} ${extra_clone_opts} ${ESCM_OPTIONS} "${ESCM_REPO_URI}" ${GIT_DIR} \
			|| die "Can't fetch from ${ESCM_REPO_URI}."

		pushd "${GIT_DIR}" &> /dev/null
		cursha1=$(git rev-parse ${upstream_branch})
		einfo "   at the commit:		${cursha1}"

		git-ng_submodules
		popd &> /dev/null
	elif [[ -n ${ESCM_OFFLINE} ]] ; then
		pushd "${GIT_DIR}" &> /dev/null
		cursha1=$(git rev-parse ${upstream_branch})
		einfo "GIT offline update -->"
		einfo "   repository: 		${ESCM_REPO_URI}"
		einfo "   at the commit:		${cursha1}"
		popd &> /dev/null
	else
		pushd "${GIT_DIR}" &> /dev/null
		# Git urls might change, so unconditionally set it here
		git config remote.origin.url "${ESCM_REPO_URI}"

		# fetch updates
		einfo "GIT update -->"
		einfo "   repository: 		${ESCM_REPO_URI}"

		oldsha1=$(git rev-parse ${upstream_branch})

		if [[ -n ${ESCM_HAS_SUBMODULES} ]]; then
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
			einfo "   updating from commit:	${oldsha1}"
			einfo "   to commit:		${cursha1}"
		else
			einfo "   at the commit: 		${cursha1}"
		fi
		git --no-pager diff --stat ${oldsha1}..${upstream_branch}
		popd &> /dev/null
	fi
	# export the version the repository is at
	export ESCM_VERSION="${cursha1}"
	# log the repo state
	[[ "${ESCM_COMMIT}" != "${ESCM_BRANCH}" ]] && einfo "   commit:			${ESCM_COMMIT}"
	einfo "   branch: 			${ESCM_BRANCH}"
	einfo "   storage directory: 	\"${GIT_DIR}\""

	git-ng_gc

	git-ng_move_source

	pushd "${SOURCE}" &> /dev/null
	git-ng_branch
	git-ng_submodules
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
		pushd "${SOURCE}" &> /dev/null
		einfo "Starting bootstrap"

		if [[ -f ${ESCM_BOOTSTRAP} ]]; then
			# we have file in the repo which we should execute
			debug-print "${FUNCNAME}: bootstraping with file \"${ESCM_BOOTSTRAP}\""

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
			debug-print "${FUNCNAME}: bootstraping with commands \"${ESCM_BOOTSTRAP}\""

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
