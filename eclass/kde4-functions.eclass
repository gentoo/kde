# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/kde4-functions.eclass,v 1.18 2009/05/09 13:23:15 scarabeus Exp $

# @ECLASS: kde4-functions.eclass
# @MAINTAINER:
# kde@gentoo.org
# @BLURB: Common ebuild functions for KDE 4 packages
# @DESCRIPTION:
# This eclass contains all functions shared by the different eclasses,
# for KDE 4 ebuilds.

# @ECLASS-VARIABLE: EAPI
# @DESCRIPTION:
# By default kde4 eclasses wants eapi 2 which might be redefinable to newer
# versions.
case ${EAPI:-0} in
	2) : ;;
	*) die "No way! EAPI other than 2 is not supported for now." ;;
esac

# @ECLASS-VARIABLE: KDEBASE
# @DESCRIPTION:
# This gets set to a non-zero value when a package is considered a kde or
# koffice ebuild.

if [[ ${CATEGORY} = kde-base ]]; then
	debug-print "${ECLASS}: KDEBASE ebuild recognized"
	KDEBASE=kde-base
fi

# is this a koffice ebuild?
if [[ ${KMNAME} = koffice || ${PN} = koffice ]]; then
	debug-print "${ECLASS}: KOFFICE ebuild recognized"
	KDEBASE=koffice
fi

# @ECLASS-VARIABLE: KDE_SLOTS
# @DESCRIPTION:
# The slots used by all KDE versions later than 4.0. The live KDE releases use
# KDE_LIVE_SLOTS instead. Values should be ordered.
KDE_SLOTS=( "kde-4" "4.1" "4.2" "4.3" )

# @ECLASS-VARIABLE: KDE_LIVE_SLOTS
# @DESCRIPTION:
# The slots used by KDE live versions. Values should be ordered.
KDE_LIVE_SLOTS=( "live" )

# @FUNCTION: buildsycoca
# @DESCRIPTION:
# Function to rebuild the KDE System Configuration Cache.
# All KDE ebuilds should run this in pkg_postinst and pkg_postrm.
buildsycoca() {
	debug-print-function ${FUNCNAME} "$@"
	
	if [[ -z ${ROOT%%/} && -x ${KDEDIR}/bin/kbuildsycoca4 ]]; then
		# Make sure tha cache file exists, writable by root and readable by
		# others. Otherwise kbuildsycoca4 will fail.
		touch "${KDEDIR}/share/kde4/services/ksycoca4"
		chmod 644 "${KDEDIR}/share/kde4/services/ksycoca4"

		# We have to unset DISPLAY and DBUS_SESSION_BUS_ADDRESS, the ones
		# in the user's environment (through su [without '-']) may cause
		# kbuildsycoca4 to hang.

		ebegin "Running kbuildsycoca4 to build global database"
		# This is needed because we support multiple kde versions installed together.
		# Lookup in order - local, KDEDIR, /usr, do not duplicate entries btw.
		local KDEDIRS="${ROOT}usr/share"
		[[ ${KDEDIR} != "${ROOT}usr" ]] && KDEDIRS="${KDEDIR}/share:${KDEDIRS}"
		XDG_DATA_DIRS="${ROOT}usr/local/share:${KDEDIRS}" \
			DISPLAY="" DBUS_SESSION_BUS_ADDRESS="" \
			${KDEDIR}/bin/kbuildsycoca4 --global --noincremental &> /dev/null
		eend $?
	fi

	# fix permission for some directories
	for x in share/config share/kde4; do
		[[ ${KDEDIR} = ${ROOT}usr ]] && DIRS=${ROOT}usr || DIRS="${ROOT}usr ${KDEDIR}"
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
		xargs -0 sed -i -e '/add_subdirectory/s/^/#DONOTCOMPILE /' -e '/ADD_SUBDIRECTORY/s/^/#DONOTCOMPILE /' || \
		die "${LINENO}: Initial sed died"
}

# @ECLASS-VARIABLE: KDE_LINGUAS
# @DESCRIPTION:
# This is a whitespace-separated list of translations this ebuild supports.
# These translations are automatically added to IUSE. Therefore ebuilds must set
# this variable before inheriting any eclasses. To enable only selected
# translations, ebuilds must call enable_selected_linguas(). kde4-base.eclass does
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
	local lingua sr_mess wp

	# ebuild overridable linguas directory definition
	KDE_LINGUAS_DIR=${KDE_LINGUAS_DIR:="${S}/po"}
	cd "${KDE_LINGUAS_DIR}" || die "wrong linguas dir specified"

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
	comment_all_add_subdirectory "${KDE_LINGUAS_DIR}"
	for lingua in ${LINGUAS}; do
		ebegin "Enabling LANGUAGE: ${lingua}"
		if [[ -d "${lingua}" ]]; then
			sed -e "/add_subdirectory([[:space:]]*${lingua}[[:space:]]*)[[:space:]]*$/ s/^#DONOTCOMPILE //" \
				-e "/ADD_SUBDIRECTORY([[:space:]]*${lingua}[[:space:]]*)[[:space:]]*$/ s/^#DONOTCOMPILE //" \
				-i CMakeLists.txt || die "Sed to uncomment linguas_${lingua} failed."
		fi
		if [[ -e "${lingua}.po.old" ]]; then
			mv "${lingua}.po.old" "${lingua}.po"
		fi
		eend $?
	done
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
	insinto ${ROOT}var/lib/kde
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
		depsfile="${ROOT}var/lib/kde/${pn}:${SLOT}"
		[[ -r "${depsfile}" ]] || die "Depsfile '${depsfile}' not accessible. You probably need to reinstall ${pn}."
		sed -i -e "${i}iINCLUDE(\"${depsfile}\")" "${S}/CMakeLists.txt" || \
			die "Failed to include library dependencies for ${pn}"
	done
	eend $?
}
