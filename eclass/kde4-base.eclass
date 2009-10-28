# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/kde4-base.eclass,v 1.51 2009/10/28 14:27:17 abcd Exp $

# @ECLASS: kde4-base.eclass
# @MAINTAINER:
# kde@gentoo.org
# @BLURB: This eclass provides functions for kde 4.X ebuilds
# @DESCRIPTION:
# The kde4-base.eclass provides support for building KDE4 based ebuilds
# and KDE4 applications.
#
# NOTE: KDE 4 ebuilds by default define EAPI="2", this can be redefined but
# eclass will fail with version older than 2.

# @ECLASS-VARIABLE: WANT_CMAKE
# @DESCRIPTION:
# Specify if cmake buildsystem is being used. Possible values are 'always' and 'never'.
# Please note that if it's set to 'never' you need to explicitly override following phases:
# src_configure, src_compile, src_test and src_install.
# Defaults to 'always'.
WANT_CMAKE="${WANT_CMAKE:-${CMAKE_REQUIRED:-always}}"
if [[ ${WANT_CMAKE} = false || ${WANT_CMAKE} = never ]]; then
	buildsystem_eclass=""
	export_fns=""
else
	buildsystem_eclass="cmake-utils"
	export_fns="src_configure src_compile src_test src_install"
fi

inherit kde4-functions

get_build_type
if [[ ${BUILD_TYPE} = live ]]; then
	subversion_eclass="subversion"
fi

inherit base ${buildsystem_eclass} eutils ${subversion_eclass}

EXPORT_FUNCTIONS pkg_setup src_unpack src_prepare  ${export_fns} pkg_postinst pkg_postrm

unset buildsystem_eclass
unset export_fns
unset subversion_eclass

case ${KDEBASE} in
	kde-base)
		HOMEPAGE="http://www.kde.org/"
		LICENSE="GPL-2"
		;;
	koffice)
		HOMEPAGE="http://www.koffice.org/"
		LICENSE="GPL-2"
		;;
esac

# @ECLASS-VARIABLE: OPENGL_REQUIRED
# @DESCRIPTION:
# Is qt-opengl required? Possible values are 'always', 'optional' and 'never'.
# This variable must be set before inheriting any eclasses. Defaults to 'never'.
OPENGL_REQUIRED="${OPENGL_REQUIRED:-never}"

# @ECLASS-VARIABLE: WEBKIT_REQUIRED
# @DESCRIPTION:
# Is qt-webkit requred? Possible values are 'always', 'optional' and 'never'.
# This variable must be set before inheriting any eclasses. Defaults to 'never'.
WEBKIT_REQUIRED="${WEBKIT_REQUIRED:-never}"

# @ECLASS-VARIABLE: CPPUNIT_REQUIRED
# @DESCRIPTION:
# Is cppunit required for tests? Possible values are 'always', 'optional' and 'never'.
# This variable must be set before inheriting any eclasses. Defaults to 'never'.
CPPUNIT_REQUIRED="${CPPUNIT_REQUIRED:-never}"

# @ECLASS-VARIABLE: KDE_REQUIRED
# @DESCRIPTION:
# Is kde required? Possible values are 'always', 'optional' and 'never'.
# This variable must be set before inheriting any eclasses. Defaults to 'always'
# If set to always or optional, KDE_MINIMAL may be overriden as well.
# Note that for kde-base packages this variable is fixed to 'always'.
KDE_REQUIRED="${KDE_REQUIRED:-always}"

# Verify KDE_MINIMAL (display QA notice in pkg_setup, still we need to fix it here)
if [[ -n ${KDE_MINIMAL} ]]; then
	for slot in ${KDE_SLOTS[@]} ${KDE_LIVE_SLOTS[@]}; do
		[[ ${KDE_MINIMAL} = ${slot} ]] && KDE_MINIMAL_VALID=1 && break
	done
	unset slot
	[[ -z ${KDE_MINIMAL_VALID} ]] && unset KDE_MINIMAL
else
	KDE_MINIMAL_VALID=1
fi

# @ECLASS-VARIABLE: KDE_MINIMAL
# @DESCRIPTION:
# This variable is used when KDE_REQUIRED is set, to specify required KDE minimal
# version for apps to work. Currently defaults to 4.3
# One may override this variable to raise version requirements.
# For possible values look at KDE_SLOTS and KDE_LIVE_SLOTS variables.
# Note that it is fixed to ${SLOT} for kde-base packages.
KDE_MINIMAL="${KDE_MINIMAL:-4.3}"

# Setup packages inheriting this eclass
case ${KDEBASE} in
	kde-base)
		if [[ $BUILD_TYPE = live ]]; then
			# Disable tests for live ebuilds
			RESTRICT+=" test"
			# Live ebuilds in kde-base default to kdeprefix by default
			IUSE+=" +kdeprefix"
		else
			# All other ebuild types default to -kdeprefix as before
			IUSE+=" kdeprefix"
		fi
		# Determine SLOT from PVs
		case ${PV} in
			*.9999*) SLOT="${PV/.9999*/}" ;; # stable live
			4.4* | 4.3.[6-9]*) SLOT="4.4" ;;
			4.3*) SLOT="4.3" ;;
			4.2*) SLOT="4.2" ;;
			9999*) SLOT="live" ;; # regular live
			*) die "Unsupported ${PV}" ;;
		esac
		# This code is to prevent portage from searching GENTOO_MIRRORS for
		# packages that will never be mirrored. (As they only will ever be in
		# the overlay).
		case ${PV} in
			*9999* | 4.?.[6-9]?)
				RESTRICT+=" mirror"
				;;
		esac
		KDE_MINIMAL="${SLOT}"
		_kdedir="${SLOT}"

		# Block installation of other SLOTS unless kdeprefix
		RDEPEND+=" $(block_other_slots)"
		;;
	koffice)
		SLOT="2"
		;;
esac

# @ECLASS-VARIABLE: QT_MINIMAL
# @DESCRIPTION:
# Determine version of qt we enforce as minimal for the package. 4.4.0 4.5.1..
# Currently defaults to 4.5.1 for KDE 4.3 and earlier
# or 4.6.0_beta for KDE 4.4 and later
if slot_is_at_least 4.4 "${KDE_MINIMAL}"; then
	QT_MINIMAL="${QT_MINIMAL:-4.6.0_beta}"
fi

QT_MINIMAL="${QT_MINIMAL:-4.5.1}"

# OpenGL dependencies
qtopengldepend="
	>=x11-libs/qt-opengl-${QT_MINIMAL}:4
"
case ${OPENGL_REQUIRED} in
	always)
		COMMONDEPEND+=" ${qtopengldepend}"
		;;
	optional)
		IUSE+=" opengl"
		COMMONDEPEND+=" opengl? ( ${qtopengldepend} )"
		;;
	*) ;;
esac
unset qtopengldepend

# WebKit dependencies
case ${KDE_REQUIRED} in
	always)
		qtwebkitusedeps="[kde]"
		;;
	optional)
		qtwebkitusedeps="[kde?]"
		;;
	*) ;;
esac
qtwebkitdepend="
	>=x11-libs/qt-webkit-${QT_MINIMAL}:4${qtwebkitusedeps}
"
unset qtwebkitusedeps
case ${WEBKIT_REQUIRED} in
	always)
		COMMONDEPEND+=" ${qtwebkitdepend}"
		;;
	optional)
		IUSE+=" webkit"
		COMMONDEPEND+=" webkit? ( ${qtwebkitdepend} )"
		;;
	*) ;;
esac
unset qtwebkitdepend

# CppUnit dependencies
cppuintdepend="
	dev-util/cppunit
"
case ${CPPUNIT_REQUIRED} in
	always)
		DEPEND+=" ${cppuintdepend}"
		;;
	optional)
		IUSE+=" test"
		DEPEND+=" test? ( ${cppuintdepend} )"
		;;
	*) ;;
esac
unset cppuintdepend

# KDE dependencies
kdecommondepend="
	dev-lang/perl
	>=x11-libs/qt-core-${QT_MINIMAL}:4[qt3support,ssl]
	>=x11-libs/qt-gui-${QT_MINIMAL}:4[accessibility,dbus]
	>=x11-libs/qt-qt3support-${QT_MINIMAL}:4[accessibility,kde]
	>=x11-libs/qt-script-${QT_MINIMAL}:4
	>=x11-libs/qt-sql-${QT_MINIMAL}:4[qt3support]
	>=x11-libs/qt-svg-${QT_MINIMAL}:4
	>=x11-libs/qt-test-${QT_MINIMAL}:4
	!aqua? (
		x11-libs/libXext
		x11-libs/libXt
		x11-libs/libXxf86vm
	)
"
if [[ ${PN} != kdelibs ]]; then
	if [[ ${KDEBASE} = kde-base ]]; then
		kdecommondepend+=" $(add_kdebase_dep kdelibs)"
		# libknotificationitem only when SLOT is 4.3
		[[ ${PN} != libknotificationitem ]] && [[ ${SLOT} = 4.3 ]] && \
			kdecommondepend+=" $(add_kdebase_dep libknotificationitem)"
	else
		kdecommondepend+="
			>=kde-base/kdelibs-${KDE_MINIMAL}
		"
	fi
fi
kdedepend="
	dev-util/pkgconfig
"
case ${KDE_REQUIRED} in
	always)
		IUSE+=" aqua"
		COMMONDEPEND+=" ${kdecommondepend}"
		DEPEND+=" ${kdedepend}"
		;;
	optional)
		IUSE+=" aqua kde"
		COMMONDEPEND+=" kde? ( ${kdecommondepend} )"
		DEPEND+=" kde? ( ${kdedepend} )"
		;;
	*) ;;
esac
unset kdecommondepend kdedepend

debug-print "${LINENO} ${ECLASS} ${FUNCNAME}: COMMONDEPEND is ${COMMONDEPEND}"
debug-print "${LINENO} ${ECLASS} ${FUNCNAME}: DEPEND (only) is ${DEPEND}"
debug-print "${LINENO} ${ECLASS} ${FUNCNAME}: RDEPEND (only) is ${RDEPEND}"

# Accumulate dependencies set by this eclass
DEPEND+=" ${COMMONDEPEND}"
RDEPEND+=" ${COMMONDEPEND}"
unset COMMONDEPEND

# Fetch section - If the ebuild's category is not 'kde-base' and if it is not a
# koffice ebuild, the URI should be set in the ebuild itself
case ${BUILD_TYPE} in
	live)
		# Determine branch URL based on live type
		local branch_prefix
		case ${PV} in
			9999*)
				# trunk
				branch_prefix="trunk/KDE"
				;;
			*)
				# branch
				branch_prefix="branches/KDE/${SLOT}"
				# @ECLASS-VARIABLE: ESVN_PROJECT_SUFFIX
				# @DESCRIPTION
				# Suffix appended to ESVN_PROJECT depending on fetched branch.
				# Defaults is empty (for -9999 = trunk), and "-${PV}" otherwise.
				ESVN_PROJECT_SUFFIX="-${PV}"
				;;
		esac
		SRC_URI=""
		# @ECLASS-VARIABLE: ESVN_MIRROR
		# @DESCRIPTION:
		# This variable allows easy overriding of default kde mirror service
		# (anonsvn) with anything else you might want to use.
		ESVN_MIRROR=${ESVN_MIRROR:=svn://anonsvn.kde.org/home/kde}
		# Split ebuild, or extragear stuff
		if [[ -n ${KMNAME} ]]; then
		    ESVN_PROJECT="${KMNAME}${ESVN_PROJECT_SUFFIX}"
			if [[ -z ${KMNOMODULE} ]] && [[ -z ${KMMODULE} ]]; then
				KMMODULE="${PN}"
			fi
			# Split kde-base/ ebuilds: (they reside in trunk/KDE)
			case ${KMNAME} in
				kdebase-*)
					ESVN_REPO_URI="${ESVN_MIRROR}/${branch_prefix}/kdebase/${KMNAME#kdebase-}"
					;;
				kdelibs-*)
					ESVN_REPO_URI="${ESVN_MIRROR}/${branch_prefix}/kdelibs/${KMNAME#kdelibs-}"
					;;
				kdereview)
					ESVN_REPO_URI="${ESVN_MIRROR}/trunk/${KMNAME}/${KMMODULE}"
					;;
				kdesupport)
					ESVN_REPO_URI="${ESVN_MIRROR}/trunk/${KMNAME}/${KMMODULE}"
					ESVN_PROJECT="${PN}${ESVN_PROJECT_SUFFIX}"
					;;
				kde*)
					ESVN_REPO_URI="${ESVN_MIRROR}/${branch_prefix}/${KMNAME}"
					;;
				extragear*|playground*)
					# Unpack them in toplevel dir, so that they won't conflict with kde4-meta
					# build packages from same svn location.
					ESVN_REPO_URI="${ESVN_MIRROR}/trunk/${KMNAME}/${KMMODULE}"
					ESVN_PROJECT="${PN}${ESVN_PROJECT_SUFFIX}"
					;;
				koffice)
					ESVN_REPO_URI="${ESVN_MIRROR}/trunk/${KMNAME}"
					;;
				*)
					ESVN_REPO_URI="${ESVN_MIRROR}/trunk/${KMNAME}/${KMMODULE}"
					;;
			esac
		else
			# kdelibs, kdepimlibs
			ESVN_REPO_URI="${ESVN_MIRROR}/${branch_prefix}/${PN}"
			ESVN_PROJECT="${PN}${ESVN_PROJECT_SUFFIX}"
		fi
		# @ECLASS-VARIABLE: ESVN_UP_FREQ
		# @DESCRIPTION:
		# This variable is used for specifying the timeout between svn synces
		# for kde-base and koffice modules. Does not affect misc apps.
		# Default value is 1 hour.
		[[ ${KDEBASE} = kde-base || ${KDEBASE} = koffice ]] && ESVN_UP_FREQ=${ESVN_UP_FREQ:-1}
		;;
	*)
		if [[ -n ${KDEBASE} ]]; then
			if [[ -n ${KMNAME} ]]; then
				case ${KMNAME} in
					kdebase-apps)
						_kmname="kdebase" ;;
					*)
						_kmname="${KMNAME}" ;;
				esac
			else
				_kmname=${PN}
			fi
			_kmname_pv="${_kmname}-${PV}"
			case ${KDEBASE} in
				kde-base)
					case ${PV} in
						4.3.85 | 4.3.9[0568])
							# block for normally packed unstable releases
							SRC_URI="mirror://kde/unstable/${PV}/src/${_kmname_pv}.tar.bz2" ;;
						4.3.[6-9]*)
							SRC_URI="http://dev.gentooexperimental.org/~alexxy/kde/${PV}/${_kmname_pv}.tar.lzma" ;;
						*)	SRC_URI="mirror://kde/stable/${PV}/src/${_kmname_pv}.tar.bz2" ;;
					esac
					;;
				koffice)
					case ${PV} in
						2.0.[6-9]*) SRC_URI="mirror://kde/unstable/${_kmname_pv}/src/${_kmname_pv}.tar.bz2" ;;
						*) SRC_URI="mirror://kde/stable/${_kmname_pv}/src/${_kmname_pv}.tar.bz2" ;;
					esac
			esac
			unset _kmname _kmname_pv
		fi
		;;
esac

debug-print "${LINENO} ${ECLASS} ${FUNCNAME}: SRC_URI is ${SRC_URI}"

# @ECLASS-VARIABLE: PREFIX
# @DESCRIPTION:
# Set the installation PREFIX for non kde-base applications. It defaults to /usr.
# kde-base packages go into KDE4 installation directory (KDEDIR) by default.
# No matter the PREFIX, package will be built against KDE installed in KDEDIR.

# @FUNCTION: kde4-base_pkg_setup
# @DESCRIPTION:
# Do the basic kdeprefix KDEDIR settings and determine with which kde should
# optional applications link
kde4-base_pkg_setup() {
	debug-print-function ${FUNCNAME} "$@"

	# Prefix compat:
	use prefix || EROOT=${ROOT}
	# Append missing trailing slash character
	[[ ${EROOT} = */ ]] || EROOT+="/"

	# QA ebuilds
	[[ -z ${KDE_MINIMAL_VALID} ]] && ewarn "QA Notice: ignoring invalid KDE_MINIMAL (defaulting to ${KDE_MINIMAL})."

	# Don't set KDEHOME during compilation, it will cause access violations
	unset KDEHOME

	if [[ ${KDEBASE} = kde-base ]]; then
		if use kdeprefix; then
			KDEDIR="${EROOT}usr/kde/${_kdedir}"
		else
			KDEDIR="${EROOT}usr"
		fi
		PREFIX="${PREFIX:-${KDEDIR}}"
	else
		# Determine KDEDIR by loooking for the closest match with KDE_MINIMAL
		KDEDIR=
		local kde_minimal_met
		for slot in ${KDE_SLOTS[@]} ${KDE_LIVE_SLOTS[@]}; do
			[[ -z ${kde_minimal_met} ]] && [[ ${slot} = ${KDE_MINIMAL} ]] && kde_minimal_met=1
			if [[ -n ${kde_minimal_met} ]] && has_version "kde-base/kdelibs:${slot}"; then
				if has_version "kde-base/kdelibs:${slot}[kdeprefix]"; then
					KDEDIR="${EROOT}usr/kde/${slot}"
				else
					KDEDIR="${EROOT}usr"
				fi
				break;
			fi
		done
		unset slot

		# Bail out if kdelibs required but not found
		if [[ ${KDE_REQUIRED} = always ]] || { [[ ${KDE_REQUIRED} = optional ]] && use kde; }; then
			[[ -z ${KDEDIR} ]] && die "Failed to determine KDEDIR!"
		else
			[[ -z ${KDEDIR} ]] && KDEDIR="${EROOT}usr"
		fi

		PREFIX="${PREFIX:-${EROOT}usr}"
	fi
	# Point pkg-config path to KDE *.pc files
	export PKG_CONFIG_PATH="${KDEDIR}/$(get_libdir)/pkgconfig${PKG_CONFIG_PATH:+:${PKG_CONFIG_PATH}}"
	# Point to correct QT plugins path
	QT_PLUGIN_PATH="${KDEDIR}/$(get_libdir)/kde4/plugins/"

	# Fix XDG collision with sandbox
	export XDG_CONFIG_HOME="${T}"
	# Not needed anymore
	unset _kdedir
}

# @FUNCTION: kde4-base_src_unpack
# @DESCRIPTION:
# This function unpacks the source tarballs for KDE4 applications.
kde4-base_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

	if [[ ${BUILD_TYPE} = live ]]; then
		migrate_store_dir
		subversion_src_unpack
	else
		base_src_unpack
	fi
}

# @FUNCTION: kde4-base_src_prepare
# @DESCRIPTION:
# General pre-configure and pre-compile function for KDE4 applications.
# It also handles translations if KDE_LINGUAS is defined. See KDE_LINGUAS and
# enable_selected_linguas() and enable_selected_doc_linguas()
# in kde4-functions.eclass(5) for further details.
kde4-base_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	# Only enable selected languages, used for KDE extragear apps.
	if [[ -n ${KDE_LINGUAS} ]]; then
		enable_selected_linguas
	fi

	# Enable/disable handbooks for kde4-base packages
	# kde-l10n inherits kde4-base but is metpackage, so no check for doc
	# kdelibs inherits kde4-base but handle installing the handbook itself
	if ! has kde4-meta ${INHERITED}; then
		has handbook ${IUSE//+} && [[ ${PN} != kde-l10n ]] && [[ ${PN} != kdelibs ]] && enable_selected_doc_linguas
	fi

	[[ ${BUILD_TYPE} = live ]] && subversion_src_prepare
	base_src_prepare

	# Save library dependencies
	if [[ -n ${KMSAVELIBS} ]] ; then
		save_library_dependencies
	fi

	# Inject library dependencies
	if [[ -n ${KMLOADLIBS} ]] ; then
		load_library_dependencies
	fi
}

# @FUNCTION: kde4-base_src_configure
# @DESCRIPTION:
# Function for configuring the build of KDE4 applications.
kde4-base_src_configure() {
	debug-print-function ${FUNCNAME} "$@"

	# Handle common release builds
	if ! has debug ${IUSE//+} || ! use debug; then
		append-cppflags -DQT_NO_DEBUG
	fi

	# Build tests in src_test only, where we override this value
	local cmakeargs="-DKDE4_BUILD_TESTS=OFF"

	# set "real" debug mode
	if has debug ${IUSE//+} && use debug; then
		CMAKE_BUILD_TYPE="Debugfull"
	fi

	# Set distribution name
	[[ ${PN} = kdelibs ]] && cmakeargs+=" -DKDE_DISTRIBUTION_TEXT=Gentoo"

	# Here we set the install prefix
	cmakeargs+=" -DCMAKE_INSTALL_PREFIX=${PREFIX}"

	# Use colors
	QTEST_COLORED=1

	# Shadow existing /usr installations
	unset KDEDIRS

	# Handle kdeprefix-ed KDE
	if [[ ${KDEDIR} != "${EROOT}usr" ]]; then
		# Override some environment variables - only when kdeprefix is different,
		# to not break ccache/distcc
		PATH="${KDEDIR}/bin:${PATH}"
		LDPATH="${KDEDIR}/$(get_libdir):${LDPATH}"

		# Append full RPATH
		cmakeargs+=" -DCMAKE_SKIP_RPATH=OFF"

		# Set cmake prefixes to allow buildsystem to locate valid KDE installation
		# when more are present
		cmakeargs+=" -DCMAKE_SYSTEM_PREFIX_PATH=${KDEDIR}"
	fi

	# Handle kdeprefix in application itself
	if ! has kdeprefix ${IUSE//+} || ! use kdeprefix; then
		# If prefix is /usr, sysconf needs to be /etc, not /usr/etc
		cmakeargs+=" -DSYSCONF_INSTALL_DIR=${EROOT}etc"
	fi

	mycmakeargs="${cmakeargs} ${mycmakeargs}"

	cmake-utils_src_configure
}

# @FUNCTION: kde4-base_src_compile
# @DESCRIPTION:
# General function for compiling KDE4 applications.
kde4-base_src_compile() {
	debug-print-function ${FUNCNAME} "$@"

	cmake-utils_src_compile "$@"
}

# @FUNCTION: kde4-base_src_test
# @DESCRIPTION:
# Function for testing KDE4 applications.
kde4-base_src_test() {
	debug-print-function ${FUNCNAME} "$@"

	# Override this value, set in kde4-base_src_configure()
	mycmakeargs+=" -DKDE4_BUILD_TESTS=ON"
	cmake-utils_src_configure
	kde4-base_src_compile

	cmake-utils_src_test
}

# @FUNCTION: kde4-base_src_install
# @DESCRIPTION:
# Function for installing KDE4 applications.
kde4-base_src_install() {
	debug-print-function ${FUNCNAME} "$@"

	if [[ -n ${KMSAVELIBS} ]] ; then
		install_library_dependencies
	fi

	kde4-base_src_make_doc
	cmake-utils_src_install
}

# @FUNCTION: kde4-base_src_make_doc
# @DESCRIPTION:
# Function for installing the documentation of KDE4 applications.
kde4-base_src_make_doc() {
	debug-print-function ${FUNCNAME} "$@"

	local doc
	for doc in AUTHORS ChangeLog* README* NEWS TODO; do
		[[ -s ${doc} ]] && dodoc ${doc}
	done

	if [[ -z ${KMNAME} ]]; then
		for doc in {apps,runtime,workspace,.}/*/{AUTHORS,README*}; do
			if [[ -s ${doc} ]]; then
				local doc_complete=${doc}
				doc="${doc#*/}"
				newdoc "$doc_complete" "${doc%/*}.${doc##*/}"
			fi
		done
	fi

	if [[ -n ${KDEBASE} ]] && [[ -d "${D}${EROOT}usr/share/doc/${PF}" ]]; then
		# work around bug #97196
		dodir /usr/share/doc/KDE4 && \
			cp -r "${D}${EROOT}usr/share/doc/${PF}" "${D}${EROOT}usr/share/doc/KDE4/" || \
			die "Failed to move docs to KDE4/."
			rm -rf "${D}${EROOT}usr/share/doc/${PF}"
	fi
}

# @FUNCTION: kde4-base_pkg_postinst
# @DESCRIPTION:
# Function to rebuild the KDE System Configuration Cache after an application has been installed.
kde4-base_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	buildsycoca

	if [[ ${BUILD_TYPE} = live ]] && [[ -z ${I_KNOW_WHAT_I_AM_DOING} ]]; then
		echo
		einfo "WARNING! This is an experimental live ebuild of ${CATEGORY}/${PN}"
		einfo "Use it at your own risk."
		einfo "Do _NOT_ file bugs at bugs.gentoo.org because of this ebuild!"
		echo
	elif [[ ${BUILD_TYPE} != live ]] && [[ -z ${I_KNOW_WHAT_I_AM_DOING} ]] && has kdeprefix ${IUSE//+} && use kdeprefix; then
		# warning about kdeprefix for non-live users
		echo
		ewarn "WARNING! You have the kdeprefix useflag enabled."
		ewarn "This setting is strongly discouraged and might lead to potential trouble"
		ewarn "with KDE update strategies."
		ewarn "You are using this setup at your own risk and the kde team does not"
		ewarn "take responsibilities for dead kittens."
		echo
	fi
}

# @FUNCTION: kde4-base_pkg_postrm
# @DESCRIPTION:
# Function to rebuild the KDE System Configuration Cache after an application has been removed.
kde4-base_pkg_postrm() {
	debug-print-function ${FUNCNAME} "$@"

	buildsycoca
}
