# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/kde4-functions.eclass,v 1.41 2010/12/29 17:56:34 tampakrap Exp $

inherit versionator

# @ECLASS: kde4-functions.eclass
# @MAINTAINER:
# kde@gentoo.org
# @BLURB: Common ebuild functions for KDE 4 packages
# @DESCRIPTION:
# This eclass contains all functions shared by the different eclasses,
# for KDE 4 ebuilds.

# @ECLASS-VARIABLE: EAPI
# @DESCRIPTION:
# By default kde4 eclasses want EAPI 2 which might be redefinable to newer
# versions.
case ${EAPI:-0} in
	2|3) : ;;
	*) die "EAPI=${EAPI} is not supported" ;;
esac

# @ECLASS-VARIABLE: KDEBASE
# @DESCRIPTION:
# This gets set to a non-zero value when a package is considered a kde or
# koffice ebuild.
if [[ ${CATEGORY} = kde-base ]]; then
	debug-print "${ECLASS}: KDEBASE ebuild recognized"
	KDEBASE=kde-base
elif [[ ${KMNAME} = koffice || ${PN} = koffice ]]; then
	debug-print "${ECLASS}: KOFFICE ebuild recognized"
	KDEBASE=koffice
elif [[ ${KMNAME} = kdevelop ]]; then
	debug-print "${ECLASS}: KDEVELOP ebuild recognized"
	KDEBASE="kdevelop"
fi

# @ECLASS-VARIABLE: KDE_SLOTS
# @DESCRIPTION:
# The slots used by all KDE versions later than 4.0. The live KDE releases use
# KDE_LIVE_SLOTS instead. Values should be ordered.
KDE_SLOTS=( "4.1" "4.2" "4.3" "4.4" "4.5" "4.6" )

# @ECLASS-VARIABLE: KDE_LIVE_SLOTS
# @DESCRIPTION:
# The slots used by KDE live versions. Values should be ordered.
KDE_LIVE_SLOTS=( "live" )

# @FUNCTION: slot_is_at_least
# @USAGE: <want> <have>
# @DESCRIPTION:
# Version aware slot comparator.
# Current implementation relies on the fact, that slots can be compared like
# string literals (and let's keep it this way).
slot_is_at_least() {
	[[ "${2}" > "${1}" || "${2}" = "${1}" ]]
}

# @FUNCTION: buildsycoca
# @DESCRIPTION:
# Function to rebuild the KDE System Configuration Cache.
# All KDE ebuilds should run this in pkg_postinst and pkg_postrm.
buildsycoca() {
	debug-print-function ${FUNCNAME} "$@"

	if [[ ${EAPI} == 2 ]] && ! use prefix; then
		EROOT=${ROOT}
	fi

	local KDE3DIR="${EROOT}usr/kde/3.5"
	if [[ -z ${EROOT%%/} && -x "${KDE3DIR}"/bin/kbuildsycoca ]]; then
		# Since KDE3 is aware of shortcuts in /usr, rebuild database
		# for KDE3 as well.
		touch "${KDE3DIR}"/share/services/ksycoca
		chmod 644 "${KDE3DIR}"/share/services/ksycoca

		ebegin "Running kbuildsycoca to build global database"
		XDG_DATA_DIRS="${EROOT}usr/local/share:${KDE3DIR}/share:${EROOT}usr/share" \
			DISPLAY="" \
			"${KDE3DIR}"/bin/kbuildsycoca --global --noincremental &> /dev/null
		eend $?
	fi

	# We no longer need to run kbuildsycoca4, as kded does that automatically, as needed

	# fix permission for some directories
	for x in share/{config,kde4}; do
		[[ ${KDEDIR} == /usr ]] && DIRS=${EROOT}usr || DIRS="${EROOT}usr ${EROOT}${KDEDIR}"
		for y in ${DIRS}; do
			[[ -d "${y}/${x}" ]] || break # nothing to do if directory does not exist
			if [[ $(stat --format=%a "${y}/${x}") != 755 ]]; then
				ewarn "QA Notice:"
				ewarn "Package ${PN} is breaking ${y}/${x} permissions."
				ewarn "Please report this issue to gentoo bugzilla."
				einfo "Permissions will get adjusted automatically now."
				find "${y}/${x}" -type d -print0 | xargs -0 chmod 755
			fi
		done
	done
}

# @FUNCTION: comment_all_add_subdirectory
# @USAGE: [list of directory names]
# @DESCRIPTION:
# Recursively comment all add_subdirectory instructions in listed directories,
# except those in cmake/.
comment_all_add_subdirectory() {
	find "$@" -name CMakeLists.txt -print0 | grep -vFzZ "./cmake" | \
		xargs -0 sed -i \
			-e '/^[[:space:]]*add_subdirectory/s/^/#DONOTCOMPILE /' \
			-e '/^[[:space:]]*ADD_SUBDIRECTORY/s/^/#DONOTCOMPILE /' \
			-e '/^[[:space:]]*macro_optional_add_subdirectory/s/^/#DONOTCOMPILE /' \
			-e '/^[[:space:]]*MACRO_OPTIONAL_ADD_SUBDIRECTORY/s/^/#DONOTCOMPILE /' \
			|| die "${LINENO}: Initial sed died"
}

# @ECLASS-VARIABLE: KDE_LINGUAS
# @DESCRIPTION:
# This is a whitespace-separated list of translations this ebuild supports.
# These translations are automatically added to IUSE. Therefore ebuilds must set
# this variable before inheriting any eclasses. To enable only selected
# translations, ebuilds must call enable_selected_linguas(). kde4-{base,meta}.eclass does
# this for you.
#
# Example: KDE_LINGUAS="en_GB de nl"
for _lingua in ${KDE_LINGUAS}; do
	IUSE="${IUSE} linguas_${_lingua}"
done

# @FUNCTION: enable_selected_linguas
# @DESCRIPTION:
# Enable translations based on LINGUAS settings and translations supported by
# the package (see KDE_LINGUAS). By default, translations are found in "${S}"/po
# but this default can be overridden by defining KDE_LINGUAS_DIR.
enable_selected_linguas() {
	debug-print-function ${FUNCNAME} "$@"

	local x

	# if there is no linguas defined we enable everything
	if ! $(env | grep -q "^LINGUAS="); then
		return 0
	fi

	# @ECLASS-VARIABLE: KDE_LINGUAS_DIR
	# @DESCRIPTION:
	# Specified folder where application translations are located.
	# Can be defined as array of folders where translations are located.
	# Note that space separated list of dirs is not supported.
	# Default value is set to "po".
	if [[ "$(declare -p KDE_LINGUAS_DIR 2>/dev/null 2>&1)" == "declare -a"* ]]; then
		debug-print "$FUNCNAME: we have these subfolders defined: ${KDE_LINGUAS_DIR}"
		for x in "${KDE_LINGUAS_DIR[@]}"; do
			_enable_selected_linguas_dir ${x}
		done
	else
		KDE_LINGUAS_DIR=${KDE_LINGUAS_DIR:="po"}
		_enable_selected_linguas_dir ${KDE_LINGUAS_DIR}
	fi
}

# @FUNCTION: enable_selected_doc_linguas
# @DESCRIPTION:
# Enable only selected linguas enabled doc folders.
enable_selected_doc_linguas() {
	debug-print-function ${FUNCNAME} "$@"

	# if there is no linguas defined we enable everything
	if ! $(env | grep -q "^LINGUAS="); then
		return 0
	fi

	# @ECLASS-VARIABLE: KDE_DOC_DIRS
	# @DESCRIPTION:
	# Variable specifying whitespace separated patterns for documentation locations.
	# Default is "doc/%lingua"
	KDE_DOC_DIRS=${KDE_DOC_DIRS:='doc/%lingua'}
	local linguas
	for pattern in ${KDE_DOC_DIRS}; do

		local handbookdir=`dirname ${pattern}`
		local translationdir=`basename ${pattern}`
		# Do filename pattern supplied, treat as directory
		[[ "${handbookdir}" = '.' ]] && handbookdir=${translationdir} && translationdir=
		[[ -d "${handbookdir}" ]] || die 'wrong doc dir specified'

		if ! use handbook; then
			# Disable whole directory
			sed -e "/add_subdirectory[[:space:]]*([[:space:]]*${handbookdir}[[:space:]]*)/s/^/#DONOTCOMPILE /" \
				-e "/ADD_SUBDIRECTORY[[:space:]]*([[:space:]]*${handbookdir}[[:space:]]*)/s/^/#DONOTCOMPILE /" \
				-i CMakeLists.txt || die 'failed to comment out all handbooks'
		else
			# Disable subdirectories recursively
			comment_all_add_subdirectory "${handbookdir}"
			# Add requested translations
			local lingua
			for lingua in en ${KDE_LINGUAS}; do
				if [[ ${lingua} = 'en' ]] || use linguas_${lingua}; then
					if [[ -d "${handbookdir}/${translationdir//%lingua/${lingua}}" ]]; then
						sed -e "/add_subdirectory[[:space:]]*([[:space:]]*${translationdir//%lingua/${lingua}}/s/^#DONOTCOMPILE //" \
							-e "/ADD_SUBDIRECTORY[[:space:]]*([[:space:]]*${translationdir//%lingua/${lingua}}/s/^#DONOTCOMPILE //" \
							-i "${handbookdir}"/CMakeLists.txt && ! has ${lingua} ${linguas} && linguas="${linguas} ${lingua}"
					fi
				fi
			done
		fi

	done
	[[ -n "${linguas}" ]] && einfo "Enabling handbook translations:${linguas}"
}

# @FUNCTION: get_build_type
# @DESCRIPTION:
# Determine whether we are using live ebuild or tbzs.
get_build_type() {
	if [[ ${SLOT} = live || ${PV} = *9999* ]]; then
		BUILD_TYPE="live"
	else
		BUILD_TYPE="release"
	fi
	export BUILD_TYPE
}

# @FUNCTION: migrate_store_dir
# @DESCRIPTION:
# Universal store dir migration
# * performs split of kdebase to kdebase-apps when needed
# * moves playground/extragear kde4-base-style to toplevel dir
migrate_store_dir() {
	local cleandir="${ESVN_STORE_DIR}/KDE"
	if [[ -d "${cleandir}" ]]; then
		ewarn "'${cleandir}' has been found. Moving contents to new location."
		addwrite "${ESVN_STORE_DIR}"
		# Split kdebase
		local module
		if pushd "${cleandir}"/kdebase/kdebase > /dev/null; then
			for module in `find . -maxdepth 1 -type d -name [a-z0-9]\*`; do
				module="${module#./}"
				mkdir -p "${ESVN_STORE_DIR}/kdebase-${module}" && mv -f "${module}" "${ESVN_STORE_DIR}/kdebase-${module}" || \
					die "Failed to move to '${ESVN_STORE_DIR}/kdebase-${module}'."
			done
			popd > /dev/null
			rm -fr "${cleandir}/kdebase" || \
				die "Failed to remove ${cleandir}/kdebase. You need to remove it manually."
		fi
		# Move the rest
		local pkg
		for pkg in "${cleandir}"/*; do
			mv -f "${pkg}" "${ESVN_STORE_DIR}"/ || eerror "Failed to move '${pkg}'"
		done
		rmdir "${cleandir}" || die "Could not move obsolete KDE store dir. Please move '${cleandir}' contents to appropriate location (possibly ${ESVN_STORE_DIR}) and manually remove '${cleandir}' in order to continue."
	fi

	if ! hasq kde4-meta ${INHERITED}; then
		case ${KMNAME} in
			extragear*|playground*)
				local svnlocalpath="${ESVN_STORE_DIR}"/"${KMNAME}"/"${PN}"
				if [[ -d "${svnlocalpath}" ]]; then
					local destdir="${ESVN_STORE_DIR}"/"${ESVN_PROJECT}"/"`basename "${ESVN_REPO_URI}"`"
					ewarn "'${svnlocalpath}' has been found."
					ewarn "Moving contents to new location: ${destdir}"
					addwrite "${ESVN_STORE_DIR}"
					mkdir -p "${ESVN_STORE_DIR}"/"${ESVN_PROJECT}" && mv -f "${svnlocalpath}" "${destdir}" \
						|| die "Failed to move to '${svnlocalpath}'"
					# Try cleaning empty directories
					rmdir "`dirname "${svnlocalpath}"`" 2> /dev/null
				fi
				;;
		esac
	fi
}

# Functions handling KMLOADLIBS and KMSAVELIBS

# @FUNCTION: save_library_dependencies
# @DESCRIPTION:
# Add exporting CMake dependencies for current package
save_library_dependencies() {
	local depsfile="${T}/${PN}:${SLOT}"

	ebegin "Saving library dependencies in ${depsfile##*/}"
	echo "EXPORT_LIBRARY_DEPENDENCIES(\"${depsfile}\")" >> "${S}/CMakeLists.txt" || \
		die "Failed to save the library dependencies."
	eend $?
}

# @FUNCTION: install_library_dependencies
# @DESCRIPTION:
# Install generated CMake library dependencies to /var/lib/kde
install_library_dependencies() {
	local depsfile="${T}/${PN}:${SLOT}"

	ebegin "Installing library dependencies as ${depsfile##*/}"
	insinto /var/lib/kde
	doins "${depsfile}" || die "Failed to install library dependencies."
	eend $?
}

# @FUNCTION: load_library_dependencies
# @DESCRIPTION:
# Inject specified library dependencies in current package
load_library_dependencies() {
	local pn i depsfile
	ebegin "Injecting library dependencies from '${KMLOADLIBS}'"

	i=0
	for pn in ${KMLOADLIBS} ; do
		((i++))
		depsfile="${EPREFIX}/var/lib/kde/${pn}:${SLOT}"
		[[ -r "${depsfile}" ]] || die "Depsfile '${depsfile}' not accessible. You probably need to reinstall ${pn}."
		sed -i -e "${i}iINCLUDE(\"${depsfile}\")" "${S}/CMakeLists.txt" || \
			die "Failed to include library dependencies for ${pn}"
	done
	eend $?
}

# @FUNCTION: block_other_slots
# @DESCRIPTION:
# Create blocks for the current package in other slots when
# installed with USE=-kdeprefix
block_other_slots() {
	debug-print-function ${FUNCNAME} "$@"

	_do_blocker ${PN} 0:${SLOT}
}

# @FUNCTION: add_blocker
# @DESCRIPTION:
# Create correct RDEPEND value for blocking correct package.
# Useful for file-collision blocks.
# Parameters are package and version(s) to block.
# add_blocker kdelibs 4.2.4
# If no version is specified, then all versions will be blocked
# If any arguments (from 2 on) contain a ":", then different versions
# are blocked in different slots. (Unlisted slots get the version without
# a ":", if none, then all versions are blocked). The parameter is then of
# the form VERSION:SLOT.  Any VERSION of 0 means that no blocker will be
# added for that slot (or, if no slot, then for any unlisted slot).
# A parameter of the form :SLOT means to block all versions from that slot.
# If VERSION begins with "<", then "!<foo" will be used instead of "!<=foo".
# As a special case, if a parameter with slot "3.5" is passed, then that slot
# may also be blocked.
#
# Versions that match "4.x.50" are equivalent to all slots up to (and including)
# "4.x", but nothing following slot "4.x"
#
# As an example, if SLOT=live, then
#    add_blocker kdelibs 0 :4.3 '<4.3.96:4.4' 9999:live
# will add the following to RDEPEND:
#    !kdeprefix? ( !kde-base/kdelibs:4.3[-kdeprefix] )
#    !kdeprefix? ( !<kde-base/kdelibs-4.3.96:4.4[-kdeprefix] )
#    !<=kde-base/kdelibs-9999:live
add_blocker() {
	debug-print-function ${FUNCNAME} "$@"

	RDEPEND+=" $(_do_blocker "$@")"
}

# @FUNCTION: add_kdebase_dep
# @DESCRIPTION:
# Create proper dependency for kde-base/ dependencies,
# adding SLOT when needed (and *only* when needed).
# This takes 1 or 2 arguments.  The first being the package
# name, the optional second, is additional USE flags to append.
# The output of this should be added directly to DEPEND/RDEPEND, and
# may be wrapped in a USE conditional (but not an || conditional
# without an extra set of parentheses).
add_kdebase_dep() {
	debug-print-function ${FUNCNAME} "$@"

	[[ -z ${1} ]] && die "Missing parameter"

	local use=${2:+,${2}}

	if [[ ${KDEBASE} = kde-base ]]; then
		# FIXME remove hack when >kdepim-4.4.5 is gone
		local FIXME_PV
		if [[ ${KMNAME} = kdepim || ${PN} = kdepim-runtime ]] && [[ ${PV} = 4.4.6* || ${PV} = 4.4.7*  || ${PV} = 4.4.8* || ${PV} = 4.4.9* ]] && [[ ${1} = kdelibs || ${1} = kdepimlibs ]]; then
			FIXME_PV=4.4.5
		# FIXME remove hack when kdepim-4.6beta is gone
		elif [[ ${KMNAME} = kdepim || ${PN} = kdepim-runtime ]] && [[ ${PV} = 4.5.93* ]] && [[ ${1} = kdelibs || ${1} = kdepimlibs ]]; then
			FIXME_PV=4.5.90
		else
			FIXME_PV=${PV}
		fi

		# if building stable-live version depend just on slot
		# to allow merging packages against more stable basic stuff
		case ${PV} in
			*.9999*)
				echo " !kdeprefix? ( >=kde-base/${1}-${SLOT}[aqua=,-kdeprefix${use}] )"
				echo " kdeprefix? ( >=kde-base/${1}-${SLOT}:${SLOT}[aqua=,kdeprefix${use}] )"
				;;
			*)
				echo " !kdeprefix? ( >=kde-base/${1}-${FIXME_PV}[aqua=,-kdeprefix${use}] )"
				echo " kdeprefix? ( >=kde-base/${1}-${FIXME_PV}:${SLOT}[aqua=,kdeprefix${use}] )"
				;;
		esac
	else
		if [[ ${KDE_MINIMAL} = live ]]; then
			echo " kde-base/${1}:${KDE_MINIMAL}[aqua=${use}]"
		else
			echo " >=kde-base/${1}-${KDE_MINIMAL}[aqua=${use}]"
		fi
	fi
}

# _greater_max_in_slot ver slot
# slot must be 4.x or live
# returns true if ver is >= the maximum possibile version in slot
_greater_max_in_slot() {
	local ver=$1
	local slot=$2
	# If slot is live, then return false
	# (nothing is greater than the maximum live version)
	[[ $slot == live ]] && return 1
	# Otherwise, for slot X.Y, test against X.Y.50
	local test=${slot}.50
	version_compare $1 ${test}
	# 1 = '<', 2 = '=', 3 = '>'
	(( $? != 1 ))
}

# _less_min_in_slot ver slot
# slot must be 4.x or live
# returns true if ver is <= the minimum possibile version in slot
_less_min_in_slot() {
	local ver=$1
	local slot=$2
	# If slot == live, then test with "9999_pre", so that 9999 tests false
	local test=9999_pre
	# If slot == X.Y, then test with X.(Y-1).50
	[[ $slot != live ]] && test=${slot%.*}.$((${slot#*.} - 1)).50
	version_compare $1 ${test}
	# 1 = '<', 2 = '=', 3 = '>'
	(( $? != 3 ))
}

# Internal function used for add_blocker and block_other_slots
# This takes the same parameters as add_blocker, but echos to
# stdout instead of updating a variable.
_do_blocker() {
	debug-print-function ${FUNCNAME} "$@"

	[[ -z ${1} ]] && die "Missing parameter"
	local pkg=kde-base/$1
	shift
	local param slot def="unset" var atom
	# The following variables will hold parameters that contain ":"
	#  - block_3_5
	#  - block_4_1
	#  - block_4_2
	#  - block_4_3
	#  - block_4_4
	#  - block_live
	for slot in 3.5 ${KDE_SLOTS[@]} ${KDE_LIVE_SLOTS[@]}; do
		local block_${slot//./_}="unset"
	done

	# This construct goes through each parameter passed, and sets
	# either def or block_* to the version passed
	for param; do
		# If the parameter does not have a ":" in it...
		if [[ ${param/:} == ${param} ]]; then
			def=${param}
		else # the parameter *does* have a ":" in it
			# so everything after the : is the slot...
			slot=${param#*:}
			# ...and everything before the : is the version
			local block_${slot//./_}=${param%:*}
		fi
	done

	for slot in ${KDE_SLOTS[@]} ${KDE_LIVE_SLOTS[@]}; do
		# ${var} contains the name of the variable we care about for this slot
		# ${!var} is it's value
		var=block_${slot//./_}
		# if we didn't pass *:${slot}, then use the unsloted value
		[[ ${!var} == "unset" ]] && var=def

		# If no version was passed, or the version is greater than the maximum
		# possible version in this slot, block all versions in this slot
		if [[ ${!var} == "unset" ]] || [[ -z ${!var} ]] || _greater_max_in_slot ${!var#<} ${slot}; then
			atom=${pkg}
		# If the version is "0" or less than the minimum possible version in
		# this slot, do nothing
		elif [[ ${!var} == "0" ]] || _less_min_in_slot ${!var#<} ${slot}; then
			continue
		# If the version passed begins with a "<", then use "<" instead of "<="
		elif [[ ${!var:0:1} == "<" ]]; then
			# this also removes the first character of the version, which is a "<"
			atom="<${pkg}-${!var:1}"
		else
			atom="<=${pkg}-${!var}"
		fi
		# we always block our own slot, ignoring kdeprefix
		if [[ ${SLOT} == ${slot} ]]; then
			echo " !${atom}:${slot}"
		else
			# we only block other slots on -kdeprefix
			echo " !kdeprefix? ( !${atom}:${slot}[-kdeprefix] )"
		fi
	done

	# This is a special case block for :3.5; it does not use the
	# default version passed, and no blocker is output *unless* a version
	# is passed, or ":3.5" is passed to explicitly request a block on all
	# 3.5 versions.
	if [[ ${block_3_5} != "unset" && ${block_3_5} != "0" ]]; then
		if [[ -z ${block_3_5} ]]; then
			atom=${pkg}
		elif [[ ${block_3_5:0:1} == "<" ]]; then
			atom="<${pkg}-${block_3_5:1}"
		else
			atom="<=${pkg}-${block_3_5}"
		fi
		echo " !${atom}:3.5"
	fi
}

# local function to enable specified translations for specified directory
# used from kde4-functions_enable_selected_linguas function
_enable_selected_linguas_dir() {
	local lingua linguas sr_mess wp
	local dir=${1}

	[[ -d  "${dir}" ]] || die "linguas dir \"${dir}\" does not exist"
	comment_all_add_subdirectory "${dir}"
	pushd "${dir}" > /dev/null

	# fix all various crazy sr@Latn variations
	# this part is only ease for ebuilds, so there wont be any die when this
	# fail at any point
	sr_mess="sr@latn sr@latin sr@Latin"
	for wp in ${sr_mess}; do
		[[ -e "${wp}.po" ]] && mv "${wp}.po" "sr@Latn.po"
		if [[ -d "${wp}" ]]; then
			# move dir and fix cmakelists
			mv "${wp}" "sr@Latn"
			sed -i \
				-e "s:${wp}:sr@Latin:g" \
				CMakeLists.txt
		fi
	done

	for lingua in ${KDE_LINGUAS}; do
		if [[ -e "${lingua}.po" ]]; then
			mv "${lingua}.po" "${lingua}.po.old"
		fi
	done

	for lingua in ${KDE_LINGUAS}; do
		if use linguas_${lingua} ; then
			if [[ -d "${lingua}" ]]; then
				linguas="${linguas} ${lingua}"
				sed -e "/add_subdirectory([[:space:]]*${lingua}[[:space:]]*)[[:space:]]*$/ s/^#DONOTCOMPILE //" \
					-e "/ADD_SUBDIRECTORY([[:space:]]*${lingua}[[:space:]]*)[[:space:]]*$/ s/^#DONOTCOMPILE //" \
					-i CMakeLists.txt || die "Sed to uncomment linguas_${lingua} failed."
			fi
			if [[ -e "${lingua}.po.old" ]]; then
				linguas="${linguas} ${lingua}"
				mv "${lingua}.po.old" "${lingua}.po"
			fi
		fi
	done
	[[ -n "${linguas}" ]] && echo ">>> Enabling languages: ${linguas}"

	popd > /dev/null
}
