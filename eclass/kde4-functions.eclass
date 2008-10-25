# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/kde4-functions.eclass,v 1.4 2008/03/13 17:57:51 ingmar Exp $

# @ECLASS: kde4-functions.eclass
# @MAINTAINER:
# kde@gentoo.org
# @BLURB: Common ebuild functions for monolithic and split KDE 4 packages
# @DESCRIPTION:
# This eclass contains all functions shared by the different eclasses,
# for KDE 4 monolithic and split ebuilds.
#
# NOTE: This eclass uses the SLOT dependencies from EAPI="1" or compatible,
# hence you must define EAPI="1" in the ebuild, before inheriting any eclasses.

# @ECLASS-VARIABLE: KDEBASE
# @DESCRIPTION:
# This gets set to a non-zero value when a package is considered a kde or
# koffice ebuild.

if [[ "${CATEGORY}" == "kde-base" ]]; then
	debug-print "${ECLASS}: KDEBASE ebuild recognized"
	KDEBASE="kde-base"
fi

# is this a koffice ebuild?
if [[ "${KMNAME}" == "koffice" || "${PN}" == "koffice" ]]; then
	debug-print "${ECLASS}: KOFFICE ebuild recognized"
	KDEBASE="koffice"
fi

# @ECLASS-VARIABLE: KDE_SLOTS
# @DESCRIPTION:
# The slots used by all KDE versions after 4.0 - this doesn't include kde-3.5 and the
# live-ebuilds that use the following var.
KDE_SLOTS=( "kde-4" "4.1" "4.2" )

# @ECLASS-VARIABLE: KDE_LIVE_SLOTS
# @DESCRIPTION:
# The slots used by all KDE live versions.
KDE_LIVE_SLOTS=( "live" )

# @FUNCTION: buildsycoca
# @DESCRIPTION:
# Function to rebuild the KDE System Configuration Cache.
# All KDE ebuilds should run this in pkg_postinst and pkg_postrm.
#
# Note that kde4-base.eclass already does this.
buildsycoca() {
	debug-print-function ${FUNCNAME} "$@"

	if [[ -x ${KDEDIR}/bin/kbuildsycoca4 && -z "${ROOT%%/}" ]]; then
		# Make sure tha cache file exists, or kbuildsycoca4 will fail
		touch "${KDEDIR}/share/kde4/services/ksycoca4"

		# We have to unset DISPLAY and DBUS_SESSION_BUS_ADDRESS, the ones
		# in the user's environment (through su [without '-']) may cause
		# kbuildsycoca4 to hang.

		ebegin "Running kbuildsycoca4 to build global database"
		# This is needed because we support multiple kde versions installed together.
		XDG_DATA_DIRS="/usr/share:${KDEDIRS//:/\/share:}/share:/usr/local/share" \
			DISPLAY="" DBUS_SESSION_BUS_ADDRESS="" \
			${KDEDIR}/bin/kbuildsycoca4 --global --noincremental &> /dev/null
		eend $?
	fi
}

# @FUNCTION: comment_all_add_subdirectory
# @USAGE: [list of directory names]
# @DESCRIPTION:
# recursively comment all add_subdirectory instructions in listed directories
# except the ones in cmake/.
comment_all_add_subdirectory() {
	find "$@" -name CMakeLists.txt -print0 | grep -vFzZ "./cmake" | \
		xargs -0 sed -i -e '/add_subdirectory/s/^/#DONOTCOMPILE /' -e '/ADD_SUBDIRECTORY/s/^/#DONOTCOMPILE /' || \
		die "${LINENO}: Initial sed died"
}

# @ECLASS-VARIABLE: KDE_LINGUAS
# @DESCRIPTION:
# This is a whitespace-separated list of translations that this ebuild supports.
# These translations automatically get added to IUSE. Therefore ebuilds must set
# this variable before inheriting any eclasses. To only enable selected
# translations ebuilds must call enable_selected_linguas(). kde4-base.eclass does
# this for you.
#
# Example: KDE_LINGUAS="en_GB de nl"
for _lingua in ${KDE_LINGUAS}; do
	IUSE="${IUSE} linguas_${_lingua}"
done

# @FUNCTION: enable_selected_linguas
# @DESCRIPTION:
# Enable translations based on LINGUAS settings and what translations are
# supported (see KDE_LINGUAS). By default translations are found in "${S}"/po
# but this default can be overridden by defining KDE_LINGUAS_DIR.
enable_selected_linguas() {
	local lingua

	for lingua in ${KDE_LINGUAS}; do
		if [ -e "${S}"/po/"${lingua}".po ]; then
			mv "${S}"/po/"${lingua}".po "${S}"/po/"${lingua}".po.old
		fi
	done
	comment_all_add_subdirectory "${KDE_LINGUAS_DIR:-${S}/po}"
	for lingua in ${LINGUAS}; do
		if [ -d "${S}"/po/"${lingua}" ]; then
			sed -e "/add_subdirectory([[:space:]]*${lingua}[[:space:]]*)[[:space:]]*$/ s/^#DONOTCOMPILE //" \
				-e "/ADD_SUBDIRECTORY([[:space:]]*${lingua}[[:space:]]*)[[:space:]]*$/ s/^#DONOTCOMPILE //" \
				-i "${KDE_LINGUAS_DIR:-${S}/po}"/CMakeLists.txt || die "Sed to uncomment linguas_${lingua} failed."
		fi
		if [ -e "${S}"/po/"${lingua}".po.old ]; then
			mv "${S}"/po/"${lingua}".po.old "${S}"/po/"${lingua}".po
		fi
	done
}

# @ECLASS-VARIABLE: QT4_BUILT_WITH_USE_CHECK
# @DESCRIPTION:
# A list of USE flags that x11-libs/qt:4 needs to be built with.
#
# This list is automatically appended to KDE4_BUILT_WITH_USE_CHECK,
# so don't call qt4_pkg_setup manually.

# @ECLASS-VARIABLE: KDE4_BUILT_WITH_USE_CHECK
# @DESCRIPTION:
# The contents of $KDE4_BUILT_WITH_USE_CHECK gets fed to built_with_use
# (eutils.eclass), line per line.
#
# Example:
# @CODE
# pkg_setup() {
# 	KDE4_BUILT_WITH_USE_CHECK="--missing true sys-apps/dbus X"
# 	use alsa && KDE4_BUILT_WITH_USE_CHECK="${KDE4_BUILT_WITH_USE_CHECK}
# 		--missing true media-libs/alsa-lib midi"
# 	kde4-base_pkg_setup
# }
# @CODE

# run built_with_use on each flag and print appropriate error messages if any
# flags are missing
_kde4-functions_built_with_use() {
	local missing opt pkg flag flags

	if [[ ${1} = "--missing" ]]; then
		missing="${1} ${2}" && shift 2
	fi
	if [[ ${1:0:1} = "-" ]]; then
		opt=${1} && shift
	fi

	pkg=${1} && shift

	for flag in "${@}"; do
		flags="${flags} ${flag}"
		if ! built_with_use ${missing} ${opt} ${pkg} ${flag}; then
			flags="${flags}*"
		else
			[[ ${opt} = "-o" ]] && return 0
		fi
	done
	if [[ "${flags# }" = "${@}" ]]; then
		return 0
	fi
	if [[ ${opt} = "-o" ]]; then
		eerror "This package requires '${pkg}' to be built with any of the following USE flags: '$*'."
	else
		eerror "This package requires '${pkg}' to be built with the following USE flags: '${flags# }'."
	fi
	return 1
}

# @FUNCTION: kde4-functions_check_use
# @DESCRIPTION:
# Check if the Qt4 libraries are built with the USE flags listed in
# $QT4_BUILT_WITH_USE_CHECK.
#
# Check if a list of packages are built with certain USE flags, as listed in
# $KDE4_BUILT_WITH_USE_CHECK.
#
# If any of the required USE flags are missing, an eerror will be printed for
# each package with missing USE flags.
kde4-functions_check_use() {
	# I like to keep flags sorted
	QT4_BUILT_WITH_USE_CHECK=$(echo "${QT4_BUILT_WITH_USE_CHECK}" | \
		tr '[:space:]' '\n' | sort | uniq | xargs)

	local line missing
	if [[ -n ${KDE4_BUILT_WITH_USE_CHECK[@]} && $(declare -p KDE4_BUILT_WITH_USE_CHECK) = 'declare -a '* ]]; then
		KDE4_BUILT_WITH_USE_CHECK=("x11-libs/qt:4 ${QT4_BUILT_WITH_USE_CHECK}"
			"${KDE4_BUILT_WITH_USE_CHECK[@]}")

		for line in "${KDE4_BUILT_WITH_USE_CHECK[@]}"; do
			[[ -z ${line} ]] && continue
			if ! _kde4-functions_built_with_use ${line}; then
				missing=true
			fi
		done
	else
		KDE4_BUILT_WITH_USE_CHECK="x11-libs/qt:4 ${QT4_BUILT_WITH_USE_CHECK}
				${KDE4_BUILT_WITH_USE_CHECK}"

		while read line; do
			[[ -z ${line} ]] && continue
			if ! _kde4-functions_built_with_use ${line}; then
				missing=true
			fi
		done <<< "${KDE4_BUILT_WITH_USE_CHECK}"
	fi
	if [[ -n ${missing} ]]; then
		echo
		eerror "Flags marked with an * are missing."
		die "Missing USE flags found"
	fi
}

# @FUNCTION: kdebase_toplevel_cmakelists
# @DESCRIPTION:
# replace includes for live ebuilds with optional requests
kdebase_toplevel_cmakelist() {
	insert=$(sed -e '/macro_optional_find_package/!d' < "${ESVN_WC_PATH}"/CMakeLists.txt)
	at=$(sed -n '/^include[[:space:]]*(/=' < "${S}"/CMakeLists.txt | sed -n '$p')
	for line in ${insert}; do
		sed "${at}a${line}" -i  "${S}"/CMakeLists.txt
	done
}

# @FUNCTION: koffice_fix_libraries
# @DESCRIPTION:
# replace weird koffice lib search with hardcoded one so it
# actualy builds and works.
koffice_fix_libraries() {
	local LIB_ARRAY R_QT_kostore R_BAS_kostore R_BAS_koodf R_KROSS_kokross R_QT_komain
	local R_CMS_pigmentcms R_BAS_pigmentcms R_BAS_koresources R_BAS_flake R_BAS_koguiutils
	local R_BAS_kopageapp R_BAS_kotext R_BAS_kowmf libname R
	case ${PN} in
		koffice-data|koffice-libs)
			;;
		*)
			### basic array
			LIB_ARRAY="kostore koodf kokross komain pigmentcms koresources flake koguiutils kopageapp kotext kowmf"
			### dep array
			R_QT_kostore="\"/usr/$(get_libdir)/qt4/libQtCore.so\"
				\"/usr/$(get_libdir)/qt4/libQtXml.so\"
				\"${KDEDIR}/$(get_libdir)/libkdecore.so\""
			R_BAS_kostore="libkostore ${R_QT_kostore}"
			R_BAS_koodf="libkoodf ${R_BAS_kostore}"
			R_KROSS_kokross="
				\"${KDEDIR}/$(get_libdir)/libkrossui.so\"
				\"${KDEDIR}/$(get_libdir)/libkrosscore.so\""
			R_BAS_kokross="libkokross ${R_BAS_koodf} ${R_KROSS_kokross}"
			R_QT_komain="\"/usr/$(get_libdir)/qt4/libQtGui.so\""
			R_BAS_komain="libkomain ${R_BAS_koodf} ${R_QT_komain}"
			R_CMS_pigmentcms="\"/usr/$(get_libdir)/liblcms.so\""
			R_BAS_pigmentcms="libpigmentcms ${R_BAS_komain} ${R_CMS_pigmentcms}"
			R_BAS_koresources="libkoresources ${R_BAS_pigmentcms}"
			R_BAS_flake="libflake ${R_BAS_pigmentcms}"
			R_BAS_koguiutils="libkoguiutils libkoresources libflake ${R_BAS_pigmentcms}"
			R_BAS_kopageapp="libkopageapp ${R_BAS_koguitls}"
			R_BAS_kotext="libkotext libkoresources libflake ${R_BAS_pigmentcms}"
			### additional unmentioned stuff
			R_BAS_kowmf="libkowmf"
			for libname in ${LIB_ARRAY}; do
				echo "Fixing library ${libname} with hardcoded path"
				for libpath in $(eval "echo \$R_BAS_${libname}"); do
					if [[ "${libpath}" != "\"/usr/"* ]]; then
						R="${R} \"${KDEDIR}/$(get_libdir)/${libpath}.so\""
					else
						R="${R} ${libpath}"
					fi
				done
				find ${S} -name CMakeLists.txt -print| xargs -i \
					sed -i \
						-e "s: ${libname} : ${R} :g" \
						-e "s: ${libname}): ${R}):g" \
						-e "s:(${libname} :(${R} :g" \
						-e "s:(${libname}):(${R}):g" \
						-e "s: ${libname}: ${R}:g" \
					{} || die "Fixing library names failed."
			done
			;;
		esac
	fi
}