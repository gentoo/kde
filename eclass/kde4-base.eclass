# Copyright 2007-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# @ECLASS: kde4-base.eclass
# @MAINTAINER:
# kde@gentoo.org
# @BLURB: This eclass provides functions for kde 4.X ebuilds
# @DESCRIPTION:
# The kde4-base.eclass provides support for building KDE4 monolithic ebuilds
# and KDE4 applications.
#
# NOTE: This eclass uses the SLOT dependencies from EAPI="1" or compatible,
# and use deps from EAPI="2", hence you must define EAPI="2" in the ebuild,
# before inheriting any eclasses.

inherit base cmake-utils eutils kde4-functions multilib

EXPORT_FUNCTIONS pkg_setup src_unpack src_configure src_compile src_test src_install pkg_postinst pkg_postrm

# Set the qt dependencies
kde4-base_set_qt_dependencies() {
	local qt qtcore qtgui qt3support qtdepend qtopengldepend

	# use dependencies
	case "${EAPI}" in
		2 | 2_pre3 | 2_pre2 | 2_pre1)

		qt="["
		case "${OPENGL_REQUIRED}" in
			always)
			qt="${qt}opengl,"
			;;
			optional)
			qt="${qt}opengl?,"
			;;
		esac
		qt="${qt}accessibility,dbus,gif,jpeg,png,qt3support,ssl,zlib]"
		qtcore="[qt3support,ssl]"
		qtgui="[accessibility,dbus]"
		qt3support="[accessibility]"
		;;
	esac

	# split qt
	qtdepend="
		x11-libs/qt-core:4${qtcore}
		x11-libs/qt-gui:4${qtgui}
		x11-libs/qt-qt3support:4${qt3support}
		x11-libs/qt-script:4
		x11-libs/qt-svg:4
		x11-libs/qt-test:4"
	qtopengldepend="x11-libs/qt-opengl:4"

	# allow monolithic qt for PV < 4.1
	case "${PV}" in
		scm|9999*|4.2*|4.1.9*|4.1.8*|4.1.7*|4.1.6*|4.1*|4.0.9*|4.0.8*) : ;;
		*)
		qtdepend="|| ( ( ${qtdepend} ) >=x11-libs/qt-4.3.3:4${qt} )"
		qtopengldepend="|| ( ${qtopengldepend} >=x11-libs/qt-4.3.3:4 )"
		;;
	esac

	# opengl dependencies
	case "${OPENGL_REQUIRED}" in
		always)
		qtdepend="${qtdepend}
			${qtopengldepend}"
		;;
		optional)
		IUSE="${IUSE} opengl"
		qtdepend="${qtdepend}
			opengl? ( ${qtopengldepend} )"
		;;
		*)
		OPENGL_REQUIRED="never"
		;;
	esac

	COMMONDEPEND="${COMMONDEPEND} ${qtdepend}"
}
kde4-base_set_qt_dependencies

# Set the cmake dependencies
case "${PV}" in
	9999*|4.2*|4.1.9*|4.1.8*|4.1.7*|4.1.6*)
		CMAKEDEPEND=">=dev-util/cmake-2.6"
		;;
	*)
		CMAKEDEPEND=">=dev-util/cmake-2.4.7-r1"
		;;
esac

# Set the common dependencies
DEPEND="${DEPEND} ${COMMONDEPEND} ${CMAKEDEPEND}
	dev-util/pkgconfig
	x11-libs/libXt
	x11-proto/xf86vidmodeproto"
RDEPEND="${RDEPEND} ${COMMONDEPEND}"

# Add the kdeprefix use flag
case "${EAPI}" in
	2 | 2_pre3 | 2_pre2 | 2_pre1)
		IUSE="${IUSE} kdeprefix"
		;;
esac

# @ECLASS-VARIABLE: OPENGL_REQUIRED
# @DESCRIPTION:
# Is qt-opengl required? Possible values are 'always', 'optional' and 'never'.
# This variable must be set before inheriting any eclasses. Defaults to 'never'.
OPENGL_REQUIRED="${OPENGL_REQUIRED:-never}"

# @ECLASS-VARIABLE: CPPUNIT_REQUIRED
# @DESCRIPTION:
# Is cppunit required for tests? Possible values are 'always', 'optional' and 'never'.
# This variable must be set before inheriting any eclasses. Defaults to 'never'.
CPPUNIT_REQUIRED="${CPPUNIT_REQUIRED:-never}"

case "${CPPUNIT_REQUIRED}" in
	always)
	DEPEND="${DEPEND} dev-util/cppunit"
	;;
	optional)
	IUSE="${IUSE} test"
	DEPEND="${DEPEND}
		test? ( dev-util/cppunit )"
	;;
	*)
	CPPUNIT_REQUIRED="never"
	;;
esac

# @ECLASS-VARIABLE: NEED_KDE
# @DESCRIPTION:
# This variable sets the version of KDE4 which will be used by the eclass.
# This variable must be set by the ebuild, for all categories except for "kde-base".
# For kde-base packages, if it is not set by the ebuild,
# it's assumed that the required KDE4 version is the latest, non-live, available.
#
# @CODE
# Acceptable values are:
#	- latest - Use latest version in the portage tree
#		Default for kde-base ebuilds. Banned for ebuilds not part of kde or koffice.
#	- svn - Use svn release (live ebuilds)
#	- :SLOT - Use any version in the SLOT specified in the NEED_KDE value.
#	- VERSION_NUMBER - Use the minimum KDE4 version specified in the NEED_KDE value.
#	- VERSION_NUMBER:SLOT - Use the minimum KDE4 version and the SLOT specified in the NEED_KDE value.
#	- none - Let the ebuild handle SLOT, kde dependencies, KDEDIR, ...
# @CODE
#
# Note: There is no default NEED_KDE for ebuilds not in kde-base or part of
# koffice, so you must set it explicitly in the ebuild, in all other cases.
if [[ -z ${NEED_KDE} ]]; then
	if [[ -n ${KDEBASE} ]]; then
		NEED_KDE="latest"
	else
		die "kde4-base.eclass inherited but NEED_KDE not defined - broken ebuild"
	fi
fi
export NEED_KDE

case ${NEED_KDE} in
	latest)
		# Should only be used by 'kde-base'-ebuilds
		if [[ "${KDEBASE}" == "kde-base" ]]; then
			case ${PV} in
				4.2*|4.1.9*|4.1.8*|4.1.7*|4.1.6*)
					_kdedir="4.2"
					_pv="-${PV}:4.2" ;;
				4.1*| 4.0.9* | 4.0.8*)
					_kdedir="4.1"
					_pv="-${PV}:4.1" ;;
				4.0*)
					_kdedir="4.0"
					_pv="-${PV}:kde-4" ;;
				3.9*)
					_kdedir="3.9"
					_pv="-${PV}:kde-4" ;;
				*)
					die "NEED_KDE=latest not supported for PV=${PV}" ;;
			esac
			_operator=">="
		else
			case ${PV} in
				4.2 | 4.1.9* | 4.1.8* | 4.1.7* | 4.1.6* ) _kdedir="4.2" ;;
				4.1 | 4.0.9* | 4.0.8*) _kdedir="4.1" ;;
				4.0*) _kdedir="4.0" ;;
				3.9*) _kdedir="3.9" ;;
				*) die "NEED_KDE=latest not supported for PV=${PV}" ;;
			esac
		fi
		;;

	# NEED_KDE=":${SLOT}"
	:kde-svn)
		_kdedir="svn"
		_pv="-${NEED_KDE}"
		export NEED_KDE="svn"
		;;
	:4.2)
		_kdedir="4.2"
		_pv="${NEED_KDE}"
		;;
	:4.1)
		_kdedir="4.1"
		_pv="${NEED_KDE}"
		;;
	:kde-4)
		_kdedir="4.0"
		_pv="${NEED_KDE}"
		;;

	# NEED_KDE="${PV}:${SLOT}"
	*:kde-svn)
		_kdedir="svn"
		_operator=">="
		_pv="-${NEED_KDE}"
		export NEED_KDE="svn"
		;;
	*:4.2)
		_kdedir="4.2"
		_operator=">="
		_pv="-${NEED_KDE}"
		;;
	*:4.1)
		_kdedir="4.1"
		_operator=">="
		_pv="-${NEED_KDE}"
		;;
	*:kde-4)
		_kdedir="4.0"
		_operator=">="
		_pv="-${NEED_KDE}"
		;;

	# NEED_KDE="${PV}"
	scm|svn|9999*)
		_kdedir="svn"
		_operator=">="
		_pv="-${NEED_KDE}:kde-svn"
		export NEED_KDE="svn"
		;;
	4.2 | 4.1.9* | 4.1.8* | 4.1.7* | 4.1.6*)
		_kdedir="4.2"
		_operator=">="
		_pv="-${NEED_KDE}"
		;;
	4.1 | 4.0.9* | 4.0.8*)
		_kdedir="4.1"
		_operator=">="
		_pv="-${NEED_KDE}:4.1"
		;;
	4.0*)
		_kdedir="4.0"
		_operator=">="
		_pv="-${NEED_KDE}:kde-4"
		;;
	3.9*)
		_kdedir="3.9"
		_operator=">="
		_pv="-${NEED_KDE}:kde-4"
		;;

	# The ebuild handles dependencies, KDEDIR, SLOT.
	none)
		:
		;;

	*)
		die "NEED_KDE=${NEED_KDE} currently not supported."
		;;
esac

if [[ ${NEED_KDE} != none ]]; then

	#Set the SLOT
	if [[ -n ${KDEBASE} ]]; then
		if [[ ${NEED_KDE} = svn ]]; then
			SLOT="kde-svn"
		else
			case ${PV} in
				4.2* | 4.1.9* | 4.1.8* | 4.1.7* | 4.1.6*) SLOT="4.2" ;;
				4.1* | 4.0.9* | 4.0.8*) SLOT="4.1" ;;
				*) SLOT="kde-4" ;;
			esac
		fi
	fi

	# Block install of other SLOTS unless kdeprefix
	case "${EAPI}" in
		2 | 2_pre3 | 2_pre2 | 2_pre1)
			for KDE_SLOT in ${KDE_SLOTS[@]}; do
				# block non kdeprefix ${PN} on other slots
				if [[ ${SLOT} != ${KDE_SLOT} ]]; then
					DEPEND="${DEPEND}
						!kdeprefix? ( !kde-base/${PN}:${KDE_SLOT}[-kdeprefix] )"
					RDEPEND="${RDEPEND}
						!kdeprefix? ( !kde-base/${PN}:${KDE_SLOT}[-kdeprefix] )"
				fi
			done
			;;
	esac

	# We only need to add the dependencies if ${PN} is not "kdelibs" or "kdepimlibs"
	if [[ ${PN} != "kdelibs" ]]; then
		case "${EAPI}" in
			2 | 2_pre3 | 2_pre2 | 2_pre1)
				DEPEND="${DEPEND} ${_operator}kde-base/kdelibs${_pv}[kdeprefix=]"
				RDEPEND="${RDEPEND}	${_operator}kde-base/kdelibs${_pv}[kdeprefix=]"
				;;
			*)
				DEPEND="${DEPEND} ${_operator}kde-base/kdelibs${_pv}"
				RDEPEND="${RDEPEND} ${_operator}kde-base/kdelibs${_pv}"
				;;
		esac
		if [[ ${PN} != "kdepimlibs" ]]; then
			case "${EAPI}" in
				2 | 2_pre3 | 2_pre2 | 2_pre1)
					DEPEND="${DEPEND} ${_operator}kde-base/kdepimlibs${_pv}[kdeprefix=]"
					RDEPEND="${RDEPEND} ${_operator}kde-base/kdepimlibs${_pv}[kdeprefix=]"
					;;
				*)
					DEPEND="${DEPEND} ${_operator}kde-base/kdepimlibs${_pv}"
					RDEPEND="${RDEPEND} ${_operator}kde-base/kdepimlibs${_pv}"
				esac
		fi
	fi

	unset _operator _pv
fi

# Fetch section - If the ebuild's category is not 'kde-base' and if it is not a
# koffice ebuild, the URI should be set in the ebuild itself
if [[ -n ${KDEBASE} ]]; then
	if [[ -n ${KMNAME} ]]; then
		_kmname=${KMNAME}
	else
		_kmname=${PN}
	fi
	_kmname_pv="${_kmname}-${PV}"
	if [[ ${NEED_KDE} != "svn" ]]; then
		case ${KDEBASE} in
			kde-base)
			case ${PV} in
				4.1.9* | 4.1.8* | 4.1.7* | 4.1.6* | 4.0.9* | 4.0.8*)
					SRC_URI="mirror://kde/unstable/${PV}/src/${_kmname_pv}.tar.bz2" ;;
				*)	SRC_URI="mirror://kde/stable/${PV}/src/${_kmname_pv}.tar.bz2";;
			esac
			;;
			koffice)
			SRC_URI="mirror://kde/unstable/${_kmname_pv}/src/${_kmname_pv}.tar.bz2"
			;;
		esac
	fi
	unset _kmname _kmname_pv
fi

debug-print "${LINENO} ${ECLASS} ${FUNCNAME}: SRC_URI is ${SRC_URI}"

# @ECLASS-VARIABLE: PREFIX
# @DESCRIPTION:
# Set the installation PREFIX. All kde-base ebuilds go into the KDE4 installation directory.
# Applications installed by the other ebuilds go into /usr/ by default, this value
# can be superseded by defining PREFIX before inheriting kde4-base.
# This value is set on pkg_setup
PREFIX=""

debug-print "${LINENO} ${ECLASS} ${FUNCNAME}: SLOT ${SLOT} - NEED_KDE ${NEED_KDE}"

# @FUNCTION: kde4-base_pkg_setup
# @DESCRIPTION:
# Adds flags needed by all of KDE 4 to $QT4_BUILT_WITH_USE_CHECK. Uses
# kde4-functions_check_use from kde4-functions.eclass to print appropriate
# errors and die if any required flags listed in $QT4_BUILT_WITH_USE_CHECK or
# $KDE4_BUILT_WITH_USE_CHECK are missing.
kde4-base_pkg_setup() {
	debug-print-function $FUNCNAME "$@"

	# Don't set KDEHOME during compile, it will cause access violations
	unset KDEHOME

	if [[ ${NEED_KDE} != none ]]; then

		# Set PREFIX
		case "${EAPI}" in
			2 | 2_pre3 | 2_pre2 | 2_pre1)
				if use kdeprefix; then
					KDEDIR="/usr/kde/${_kdedir}"
					KDEDIRS="/usr:/usr/local:${KDEDIR}"
				else
					KDEDIR="/usr"
					KDEDIRS="/usr:/usr/local"
				fi
				;;
			*)
				KDEDIR="/usr"
				KDEDIRS="/usr:/usr/local"
				;;
		esac
	fi
	
	if [[ -n ${KDEBASE} ]]; then
		PREFIX=${KDEDIR}
	else
		# if PREFIX is not defined we set it to the default value of /usr
		PREFIX="${PREFIX:-/usr}"
	fi

	unset _kdedir

	case "${EAPI}" in
		2 | 2_pre3 | 2_pre2 | 2_pre1)
		[[ -n ${QT4_BUILT_WITH_USE_CHECK} || -n ${KDE4_BUILT_WITH_USE_CHECK[@]} ]] && \
			die "built_with_use illegal in this EAPI!"
		;;
		*)
		# Make KDE4_BUILT_WITH_USE_CHECK an array if it isn't already
		local line kde4_built_with_use_check=()
		if [[ -n ${KDE4_BUILT_WITH_USE_CHECK[@]} && $(declare -p KDE4_BUILT_WITH_USE_CHECK) != 'declare -a '* ]]; then
			while read line; do
				[[ -z ${line} ]] && continue
				kde4_built_with_use_check+=("${line}")
			done <<< "${KDE4_BUILT_WITH_USE_CHECK}"
			KDE4_BUILT_WITH_USE_CHECK=("${kde4_built_with_use_check[@]}")
		fi

		# KDE4 applications require qt4 compiled with USE="accessibility dbus gif jpeg png qt3support ssl zlib".
		if has_version '<x11-libs/qt-4.4_alpha:4'; then
			QT4_BUILT_WITH_USE_CHECK="${QT4_BUILT_WITH_USE_CHECK} accessibility dbus gif jpeg png qt3support ssl zlib"
		else
			KDE4_BUILT_WITH_USE_CHECK=("${KDE4_BUILT_WITH_USE_CHECK[@]}"
				"x11-libs/qt-core qt3support ssl"
				"x11-libs/qt-gui accessibility dbus"
				"x11-libs/qt-qt3support accessibility")
		fi

		if has opengl ${IUSE//+} && use opengl || [[ ${OPENGL_REQUIRED} == always ]]; then
			if has_version '<x11-libs/qt-4.4.0_alpha:4'; then
				QT4_BUILT_WITH_USE_CHECK="${QT4_BUILT_WITH_USE_CHECK} opengl"
			fi
		fi
		kde4-functions_check_use
		;;
	esac
}

# @FUNCTION: kde4-base_apply_patches
# @DESCRIPTION:
# This function applies patches.
#
# If the directory ${WORKDIR}/patches/ exists, we apply all patches in that
# directory, provided they follow this format:
# @CODE
# - Monolithic ebuilds, (from kde-base)
#		- $CATEGORY=kde-base:
#			Apply ${CHILD_EBUILD_NAME}-${SLOT}-*{diff,patch}
#		- $CATEGORY=!kde-base:
#			Apply ${CHILD_EBUILD_NAME}-${PV}-*{diff,patch}
# - Split ebuilds:
#		- $CATEGORY=kde-base:
#			Apply ${PN}-${SLOT}-*{diff,patch}
#		- $CATEGORY!=kde-base:
#			Apply ${PN}-${PV}-*{diff,patch}
# @CODE
#
# If ${PATCHES} is non-zero all patches in it get applied. If there is more
# than one patch please make ${PATCHES} an array for proper quoting.
kde4-base_apply_patches() {
	local _patchdir _packages _p _f
	_patchdir="${WORKDIR}/patches/"
	if [[ -d "${_patchdir}" ]]; then
		if is-parent-package ${CATEGORY}/${PN} ; then
			_packages="$(get-child-packages ${CATEGORY}/${PN})"
			_packages="${_packages//${CATEGORY}\//} ${PN}"
		else
			_packages="${PN}"
		fi
		if [[ $(declare -p PATCHES) != 'declare -a '* ]]; then
			die "PATCHES needs to be an array!"
		fi
		for _p in ${_packages}; do
			for _f in "${_patchdir}"/${_p}-${PV}-*{diff,patch}; do
				[[ -e ${_f} ]] && PATCHES+=("${_f}")
			done
			if [[ -n "${KDEBASE}" ]]; then
				for _f in "${_patchdir}"/${_p}-${SLOT}-*{diff,patch}; do
					[[ -e ${_f} ]] && PATCHES+=("${_f}")
				done
			fi
		done
	fi
	[[ -n ${PATCHES[@]} ]] && base_src_unpack autopatch
}

# @FUNCTION: kde4-base_src_unpack
# @DESCRIPTION:
# This function unpacks the source tarballs for KDE4 applications.
#
# If no argument is passed to this function, then standard src_unpack is
# executed. Otherwise options are passed to base_src_unpack.
#
# In addition it calls kde4-base_apply_patches when no arguments are passed to
# this function.
#
# It also handles translations if KDE_LINGUAS is defined. See KDE_LINGUAS and
# enable_selected_linguas() in kde4-functions.eclass(5) for further details.
kde4-base_src_unpack() {
	debug-print-function $FUNCNAME "$@"

	[[ -z "${KDE_S}" ]] && KDE_S="${S}"

	if [[ -z $* ]]; then
		# Unpack first and deal with KDE patches after examing possible patch sets.
		# To be picked up, patches need to conform to the guidelines stated before.
		# Monolithic ebuilds will use the split ebuild patches.
		[[ -d "${KDE_S}" ]] || unpack ${A}
		kde4-base_apply_patches
	else
		# Call base_src_unpack, which unpacks and patches
		# step by step transparently as defined in the ebuild.
		base_src_unpack $*
	fi

	# Updated cmake dir
	if [[ -d "${WORKDIR}/cmake" ]] && [[ -d "${KDE_S}/cmake" ]]; then
		ebegin "Updating cmake/ directory..."
		rm -rf "${KDE_S}/cmake" || die "Unable to remove old cmake/ directory"
		ln -s "${WORKDIR}/cmake" "${KDE_S}/cmake" || die "Unable to symlink the new cmake/ directory"
		eend 0
	fi

	# Only enable selected languages, used for KDE extragear apps.
	if [[ -n ${KDE_LINGUAS} ]]; then
		enable_selected_linguas
	fi
}

# @FUNCTION: kde4-base_src_compile
# @DESCRIPTION:
# General function for compiling KDE4 applications.
kde4-base_src_compile() {
	debug-print-function ${FUNCNAME} "$@"
	case "${EAPI}" in
		2 | 2_pre3 | 2_pre2 | 2_pre1)
			;;
		*)
			kde4-base_src_configure
			;;
	esac
	if [[ -d ${WORKDIR}/${PN}_build ]]; then
		pushd "${WORKDIR}"/${PN}_build > /dev/null
	fi
	[ -e [Mm]akefile ] && kde4-base_src_make
}

# @FUNCTION: kde4-base_src_configure
# @DESCRIPTION:
# Function for configuring the build of KDE4 applications.
kde4-base_src_configure() {
	debug-print-function ${FUNCNAME} "$@"

	# Final flag handling
	if has kdeenablefinal ${IUSE//+} && use kdeenablefinal; then
		echo "Activating enable-final flag"
		mycmakeargs="${mycmakeargs} -DKDE4_ENABLE_FINAL=ON"
	fi

	 # Enable generation of HTML handbook
	if has htmlhandbook ${IUSE//+} && use htmlhandbook; then
		echo "Enabling building of HTML handbook"
		mycmakeargs="${mycmakeargs} -DKDE4_ENABLE_HTMLHANDBOOK=ON"
	fi

	# Build tests in src_test only, where we override this value
	mycmakeargs="${mycmakeargs} -DKDE4_BUILD_TESTS=OFF"

	# Set distribution name
	[[ ${PN} == "kdelibs" ]] && mycmakeargs="${mycmakeargs} -DKDE_DISTRIBUTION_TEXT=Gentoo"

	# runpath linking
	mycmakeargs="${mycmakeargs} -DKDE4_USE_ALWAYS_FULL_RPATH=ON"

	# Here we set the install prefix
	mycmakeargs="${mycmakeargs} -DCMAKE_INSTALL_PREFIX=${PREFIX}"

	# If prefix is /usr, sysconf needs to be /etc, not /usr/etc
	[[ "${PREFIX}" == "/usr" ]] && mycmakeargs="${mycmakeargs} -DSYSCONF_INSTALL_DIR=/etc"

	# Set environment
	QTEST_COLORED=1
	QT_PLUGIN_PATH=${KDEDIR}/$(get_libdir)/kde4/plugins/

	# hardcode path to *.cmake KDE files
	PKG_CONFIG_PATH="${PKG_CONFIG_PATH:+${PKG_CONFIG_PATH}:}${KDEDIR}/$(get_libdir)/pkgconfig"

	[ -e CMakeLists.txt ] && cmake-utils_src_configureout
}

# @FUNCTION: kde4-base_src_make
# @DESCRIPTION:
# Function for building KDE4 applications.
# Options are passed to cmake-utils_src_make.
kde4-base_src_make() {
	debug-print-function ${FUNCNAME} "$@"

	cmake-utils_src_make "$@"
}

# @FUNCTION: kde4-base_src_test
# @DESCRIPTION:
# Function for testing KDE4 applications.
kde4-base_src_test() {
	debug-print-function ${FUNCNAME} "$@"

	# Override this value, set in kde4-base_src_configure()
	mycmakeargs="${mycmakeargs} -DKDE4_BUILD_TESTS=ON"
	cmake-utils_src_compile

	cmake-utils_src_test
}

# @FUNCTION: kde4-base_src_install
# @DESCRIPTION:
# Function for installing KDE4 applications.
kde4-base_src_install() {
	debug-print-function ${FUNCNAME} "$@"

	kde4-base_src_make_doc
	if [[ -d ${WORKDIR}/${PN}_build ]]; then
		pushd "${WORKDIR}"/${PN}_build > /dev/null
	fi
	[ -e [Mm]akefile ] && cmake-utils_src_install
}

# @FUNCTION: kde4-base_src_make_doc
# @DESCRIPTION:
# Function for installing the documentation of KDE4 applications.
kde4-base_src_make_doc() {
	debug-print-function ${FUNCNAME} "$@"

	local doc
	for doc in AUTHORS ChangeLog* README* NEWS TODO; do
		[[ -s $doc ]] && dodoc ${doc}
	done

	if [[ -z ${KMNAME} ]]; then
		for doc in {apps,runtime,workspace,.}/*/{AUTHORS,README*}; do
			if [[ -s $doc ]]; then
				local doc_complete=${doc}
				doc="${doc#*/}"
				newdoc "$doc_complete" "${doc%/*}.${doc##*/}"
			fi
		done
	fi

	if [[ -n ${KDEBASE} && -d "${D}"/usr/share/doc/${PF} ]]; then
		# work around bug #97196
		dodir /usr/share/doc/kde && \
			mv "${D}"/usr/share/doc/${PF} "${D}"/usr/share/doc/kde/ || \
			die "Failed to move docs to kde/ failed."
	fi
}

# @FUNCTION: kde4-base_pkg_postinst
# @DESCRIPTION:
# Function to rebuild the KDE System Configuration Cache after an application has been installed.
kde4-base_pkg_postinst() {
	buildsycoca
}

# @FUNCTION: kde4-base_pkg_postrm
# @DESCRIPTION:
# Function to rebuild the KDE System Configuration Cache after an application has been removed.
kde4-base_pkg_postrm() {
	buildsycoca
}
