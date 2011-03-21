# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# @ECLASS: git-2.eclass
# @MAINTAINER:
# Tomas Chvatal <scarabeus@gentoo.org>
# @BLURB: This eclass provides functions for fetch and unpack git repositories
# @DESCRIPTION:
# Eclass for easing maitenance of live ebuilds using git as remote repository.
# Eclass support working with git submodules and branching.

# This eclass support all EAPIs
EXPORT_FUNCTIONS src_unpack

DEPEND="dev-vcs/git"

# This static variable is for storing the data in WORKDIR.
# Sometimes we might want to redefine S.
EGIT_SOURCEDIR="${WORKDIR}/${P}"

# @FUNCTION: git-2_init_variables
# @DESCRIPTION:
# Internal function initializing all git variables.
# We define it in function scope so user can define
# all the variables before and after inherit.
git-2_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	# @ECLASS-VARIABLE: EGIT_STORE_DIR
	# @DESCRIPTION:
	# Storage directory for git sources.
	: ${EGIT_STORE_DIR:="${PORTAGE_ACTUAL_DISTDIR-${DISTDIR}}/egit-src"}

	# @ECLASS-VARIABLE: EGIT_HAS_SUBMODULES
	# @DESCRIPTION:
	# Set this to non-empty value to enable submodule support.
	: ${EGIT_HAS_SUBMODULES:=}

	# @ECLASS-VARIABLE: EGIT_FETCH_CMD
	# @DESCRIPTION:
	# Command for cloning the repository.
	: ${EGIT_FETCH_CMD:="git clone"}

	# @ECLASS-VARIABLE: EGIT_UPDATE_CMD
	# @DESCRIPTION:
	# Git fetch command.
	: ${EGIT_UPDATE_CMD:="git pull -f -u"}

	# @ECLASS-VARIABLE: EGIT_OPTIONS
	# @DESCRIPTION:
	# This variable value is passed to clone and fetch.
	: ${EGIT_OPTIONS:=}

	# @ECLASS-VARIABLE: EGIT_MASTER
	# @DESCRIPTION:
	# Variable for specifying master branch.
	# Usefull when upstream don't have master branch.
	: ${EGIT_MASTER:=master}

	# @ECLASS-VARIABLE: EGIT_REPO_URI
	# @DESCRIPTION:
	# URI for the repository
	# e.g. http://foo, git://bar
	#
	# Support multiple values:
	# EGIT_REPO_URI="git://a/b.git http://c/d.git"
	eval X="\$${PN//[-+]/_}_LIVE_REPO"
	if [[ ${X} = "" ]]; then
		: ${EGIT_REPO_URI:=}
	else
		EGIT_REPO_URI="${X}"
	fi
	[[ -z ${EGIT_REPO_URI} ]] && die "EGIT_REPO_URI must have some value."

	# @ECLASS-VARIABLE: EVCS_OFFLINE
	# @DESCRIPTION:
	# Set this variable to a non-empty value to disable the automatic updating
	# of an GIT source tree. This is intended to be set outside the git source
	# tree by users.
	: ${EVCS_OFFLINE:=}

	# @ECLASS-VARIABLE: EGIT_BRANCH
	# @DESCRIPTION:
	# Specify the branch we want to check out from the repository
	eval X="\$${PN//[-+]/_}_LIVE_BRANCH"
	if [[ "${X}" = "" ]]; then
		: ${EGIT_BRANCH:=${EGIT_MASTER}}
	else
		EGIT_BRANCH="${X}"
	fi

	# @ECLASS-VARIABLE: EGIT_COMMIT
	# @DESCRIPTION:
	# Specify commit we want to check out from the repository.
	eval X="\$${PN//[-+]/_}_LIVE_COMMIT"
	if [[ "${X}" = "" ]]; then
		: ${EGIT_COMMIT:=${EGIT_BRANCH}}
	else
		EGIT_COMMIT="${X}"
	fi

	# @ECLASS-VARIABLE: EGIT_REPACK
	# @DESCRIPTION:
	# Set to non-empty value to repack objects to save disk space. However this
	# can take a REALLY LONG time with VERY big repositories.
	: ${EGIT_REPACK:=}

	# @ECLASS-VARIABLE: EGIT_PRUNE
	# @DESCRIPTION:
	# Set to non-empty value to prune loose objects on each fetch. This is
	# useful if upstream rewinds and rebases branches often.
	: ${EGIT_PRUNE:=}

}

# @FUNCTION: git-2_submodules
# @DESCRIPTION:
# Internal function wrapping the submodule initialisation and update
git-2_submodules() {
	debug-print-function ${FUNCNAME} "$@"

	[[ "$#" -ne 1 ]] && die "${FUNCNAME}: requires 1 argument (path)"

	debug-print "${FUNCNAME}: working in \"${1}\""
	pushd "${1}" &> /dev/null

	# for submodules operations we need to be online
	if [[ -z ${EVCS_OFFLINE} && -n ${EGIT_HAS_SUBMODULES} ]]; then
		export GIT_DIR=${EGIT_DIR}
		debug-print "${FUNCNAME}: git submodule init"
		git submodule init \
			|| die "${FUNCNAME}: git submodule initialisation failed"
		debug-print "${FUNCNAME}: git submodule sync"
		git submodule sync "" die "${FUNCNAME}: git submodule sync failed"
		debug-print "${FUNCNAME}: git submodule update"
		git submodule update || die "${FUNCNAME}: git submodule update failed"
		unset GIT_DIR
	fi

	popd > /dev/null
}

# @FUNCTION: git-2_branch
# @DESCRIPTION:
# Internal function that changes branch for the repo based on EGIT_COMMIT and
# EGIT_BRANCH variables.
git-2_branch() {
	debug-print-function ${FUNCNAME} "$@"

	debug-print "${FUNCNAME}: working in \"${EGIT_SOURCEDIR}\""
	pushd "${EGIT_SOURCEDIR}" &> /dev/null

	local branchname=branch-${EGIT_BRANCH} src=origin/${EGIT_BRANCH}
	if [[ "${EGIT_COMMIT}" != "${EGIT_BRANCH}" ]]; then
		branchname=tree-${EGIT_COMMIT}
		src=${EGIT_COMMIT}
	fi
	debug-print "${FUNCNAME}: git checkout -b ${branchname} ${src}"
	git checkout -b ${branchname} ${src} \
		|| die "${FUNCNAME}: changing the branch failed"

	popd > /dev/null

	unset branchname src
}

# @FUNCTION: git-2_gc
# @DESCRIPTION:
# Internal function running garbage collector on checked out tree.
git-2_gc() {
	debug-print-function ${FUNCNAME} "$@"

	pushd "${EGIT_DIR}" &> /dev/null
	if [[ -n ${EGIT_REPACK} || -n ${EGIT_PRUNE} ]]; then
		ebegin "Garbage collecting the repository"
		local args
		[[ -n ${EGIT_PRUNE} ]] && args='--prune'
		debug-print "${FUNCNAME}: git gc ${args}"
		git gc ${args}
		eend $?
	fi
	popd &> /dev/null
}

# @FUNCTION: git-2_prepare_storedir
# @DESCRIPTION:
# Internal function preparing directory where we are going to store SCM
# repository.
git-2_prepare_storedir() {
	debug-print-function ${FUNCNAME} "$@"

	local clone_dir
	local save_sandbox_write=${SANDBOX_WRITE}

	# initial clone, we have to create master git storage directory and play
	# nicely with sandbox
	if [[ ! -d "${EGIT_STORE_DIR}" ]] ; then
		debug-print "${FUNCNAME}: Creating git main storage directory"
		addwrite /
		mkdir -p "${EGIT_STORE_DIR}" \
			|| die "${FUNCNAME}: can't mkdir \"${EGIT_STORE_DIR}\"."
		SANDBOX_WRITE=${save_sandbox_write}
	fi

	cd -P "${EGIT_STORE_DIR}" \
		|| die "${FUNCNAME}:  can't chdir to \"${EGIT_STORE_DIR}\""
	# allow writing into EGIT_STORE_DIR
	addwrite "${EGIT_STORE_DIR}"
	# calculate the proper store dir for data
	[[ -z ${EGIT_REPO_URI##*/} ]] && EGIT_REPO_URI="${EGIT_REPO_URI%/}"
	clone_dir="${EGIT_REPO_URI##*/}"
	export EGIT_DIR="${EGIT_STORE_DIR}/${clone_dir}"
	debug-print "${FUNCNAME}: Storing the repo into \"${EGIT_DIR}\"."

	# we can not jump between using and not using SUBMODULES so we need to
	# refetch the source when needed
	if [[ -d "${EGIT_DIR}" && ! -d "${EGIT_DIR}"/.git ]]; then
		debug-print "${FUNCNAME}: \"${clone_dir}\" was bare copy moving..."
		mv "${EGIT_DIR}" "${EGIT_DIR}.bare" \
			|| die "${FUNCNAME}: Moving the bare sources failed."

	fi
	# Tell user that he can remove his bare repository. It is not used.
	if [[ -d "${EGIT_DIR}.bare" ]]; then
		einfo "Found GIT bare repository at \"${EGIT_DIR}.bare\"."
		einfo "This folder can be safely removed to save space."
	fi
}

# @FUNCTION: git-2_move_source
# @DESCRIPTION:
# Internal function moving sources from the EGIT_DIR to EGIT_SOURCEDIR dir.
git-2_move_source() {
	debug-print-function ${FUNCNAME} "$@"

	pushd "${EGIT_DIR}" &> /dev/null
	debug-print "${FUNCNAME}: rsync -rlpgo . \"${EGIT_SOURCEDIR}\""
	rsync -rlpgo . "${EGIT_SOURCEDIR}" \
		|| die "${FUNCNAME}: sync to \"${EGIT_SOURCEDIR}\" failed"
	popd &> /dev/null
}

# @FUNCTION: git-2_initial_clone
# @DESCRIPTION:
# Run initial clone on specified repo_uri
git-2_initial_clone() {
	debug-print-function ${FUNCNAME} "$@"

	local repo_uri

	for repo_uri in ${EGIT_REPO_URI}; do
		debug-print "${FUNCNAME}: ${EGIT_FETCH_CMD} ${EGIT_OPTIONS} \"${repo_uri}\" \"${EGIT_DIR}\""
		${EGIT_FETCH_CMD} ${EGIT_OPTIONS} "${repo_uri}" "${EGIT_DIR}"
		if [[ $? -eq 0 ]]; then
			# global variable containing the repo_name we will be using
			debug-print "${FUNCNAME}: EGIT_REPO_URI_SELECTED=\"${repo_uri}\""
			EGIT_REPO_URI_SELECTED="${repo_uri}"
			break
		fi
	done

	if [[ -z ${EGIT_REPO_URI_SELECTED} ]]; then
		die "${FUNCNAME}: can't fetch from ${EGIT_REPO_URI}."
	fi
}

# @FUNCTION: git-2_update_repo
# @DESCRIPTION:
# Run update command on specified repo_uri
git-2_update_repo() {
	debug-print-function ${FUNCNAME} "$@"

	local repo_uri

	# checkout master branch and drop all other local branches
	git checkout ${EGIT_MASTER}
	for x in $(git branch |grep -v "* ${EGIT_MASTER}" |tr '\n' ' '); do
		debug-print "${FUNCNAME}: git branch -D ${x}"
		git branch -D ${x}
	done

	for repo_uri in ${EGIT_REPO_URI}; do
		# git urls might change, so reset it
		git config remote.origin.url "${repo_uri}"

		debug-print "${EGIT_UPDATE_CMD} ${EGIT_OPTIONS}"
		${EGIT_UPDATE_CMD} ${EGIT_OPTIONS}

		if [[ $? -eq 0 ]]; then
			# global variable containing the repo_name we will be using
			debug-print "${FUNCNAME}: EGIT_REPO_URI_SELECTED=\"${repo_uri}\""
			EGIT_REPO_URI_SELECTED="${repo_uri}"
			break
		fi
	done

	if [[ -z ${EGIT_REPO_URI_SELECTED} ]]; then
		die "${FUNCNAME}: can't update from ${EGIT_REPO_URI_SELECTED}."
	fi
}

# @FUNCTION: git-2_fetch
# @DESCRIPTION:
# Internal function fetching repository from EGIT_REPO_URI and storing it in
# specified EGIT_STORE_DIR.
git-2_fetch() {
	debug-print-function ${FUNCNAME} "$@"

	local oldsha cursha upstream_branch

	upstream_branch=origin/${EGIT_BRANCH}

	if [[ ! -d ${EGIT_DIR} ]] ; then
		git-2_initial_clone
		pushd "${EGIT_DIR}" &> /dev/null
		cursha=$(git rev-parse ${upstream_branch})
		einfo "GIT NEW clone -->"
		einfo "   repository:               ${EGIT_REPO_URI_SELECTED}"
		einfo "   at the commit:            ${cursha}"

		git-2_submodules "${EGIT_DIR}"
		popd &> /dev/null
	elif [[ -n ${EVCS_OFFLINE} ]] ; then
		pushd "${EGIT_DIR}" &> /dev/null
		cursha=$(git rev-parse ${upstream_branch})
		einfo "GIT offline update -->"
		einfo "   repository:               $(git config remote.origin.url)"
		einfo "   at the commit:            ${cursha}"
		popd &> /dev/null
	else
		pushd "${EGIT_DIR}" &> /dev/null
		oldsha=$(git rev-parse ${upstream_branch})
		git-2_update_repo
		cursha=$(git rev-parse ${upstream_branch})

		# fetch updates
		einfo "GIT update -->"
		einfo "   repository:               ${EGIT_REPO_URI_SELECTED}"
		# write out message based on the revisions
		if [[ "${oldsha1}" != "${cursha1}" ]]; then
			einfo "   updating from commit:     ${oldsha}"
			einfo "   to commit:                ${cursha}"
		else
			einfo "   at the commit:            ${cursha}"
		fi

		git-2_submodules "${EGIT_DIR}"

		# print nice statistic of what was changed
		git --no-pager diff --stat ${oldsha}..${upstream_branch}
		popd &> /dev/null
	fi
	# export the version the repository is at
	export EGIT_VERSION="${cursha1}"
	# log the repo state
	[[ "${EGIT_COMMIT}" != "${EGIT_BRANCH}" ]] \
		&& einfo "   commit:                   ${EGIT_COMMIT}"
	einfo "   branch:                   ${EGIT_BRANCH}"
	einfo "   storage directory:        \"${EGIT_DIR}\""
}

# @FUNCTION: git_bootstrap
# @DESCRIPTION:
# Internal function that runs bootstrap command on unpacked source.
git-2_bootstrap() {
	debug-print-function ${FUNCNAME} "$@"

	# @ECLASS_VARIABLE: EGIT_BOOTSTRAP
	# @DESCRIPTION:
	# Command to be executed after checkout and clone of the specified
	# repository.
	# enviroment the package will fail if there is no update, thus in
	# combination with --keep-going it would lead in not-updating
	# pakcages that are up-to-date.
	if [[ -n ${EGIT_BOOTSTRAP} ]] ; then
		pushd "${EGIT_SOURCEDIR}" &> /dev/null
		einfo "Starting bootstrap"

		if [[ -f ${EGIT_BOOTSTRAP} ]]; then
			# we have file in the repo which we should execute
			debug-print "${FUNCNAME}: bootstraping with file \"${EGIT_BOOTSTRAP}\""

			if [[ -x ${EGIT_BOOTSTRAP} ]]; then
				eval "./${EGIT_BOOTSTRAP}" \
					|| die "${FUNCNAME}: bootstrap script failed"
			else
				eerror "\"${EGIT_BOOTSTRAP}\" is not executable."
				eerror "Report upstream, or bug ebuild maintainer to remove bootstrap command."
				die "\"${EGIT_BOOTSTRAP}\" is not executable."
			fi
		else
			# we execute some system command
			debug-print "${FUNCNAME}: bootstraping with commands \"${EGIT_BOOTSTRAP}\""

			eval "${EGIT_BOOTSTRAP}" \
				|| die "${FUNCNAME}: bootstrap commands failed."
		fi

		einfo "Bootstrap finished"
		popd > /dev/null
	fi
}

# @FUNCTION: git-2_src_unpack
# @DESCRIPTION:
# src_upack function
git-2_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

	git-2_init_variables
	git-2_prepare_storedir
	git-2_fetch $@
	git-2_gc
	git-2_move_source
	git-2_branch
	git-2_submodules "${EGIT_SOURCEDIR}"
	git-2_bootstrap
	echo ">>> Unpacked to ${EGIT_SOURCEDIR}"
}
