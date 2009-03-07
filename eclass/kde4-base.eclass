# Copyright 2007-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

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

inherit base cmake-utils eutils kde4-functions

get_build_type
if [[ ${BUILD_TYPE} = live ]]; then
	inherit subversion
fi

EXPORT_FUNCTIONS pkg_setup src_unpack src_prepare src_configure src_compile src_test src_install pkg_postinst pkg_postrm

# @FUNCTION: kde4-base_set_qt_dependencies
# @DESCRIPTION:
# Set qt dependencies. And use opengl based on OPENGL_REQUIRED variable.
kde4-base_set_qt_dependencies() {
	local qtdepend qtopengldepend

	qtdepend="
		x11-libs/qt-core:4[qt3support,ssl]
		x11-libs/qt-gui:4[accessibility,dbus]
		x11-libs/qt-qt3support:4[accessibility]
		x11-libs/qt-script:4
		x11-libs/qt-sql:4[qt3support]
		x11-libs/qt-svg:4
		x11-libs/qt-test:4
	"
	qtwebkitdepend="
		x11-libs/qt-webkit:4
	"
	qtopengldepend="
		x11-libs/qt-opengl:4
	"

	case ${WEBKIT_REQUIRED} in
		always)
			qtdepend="${qtdepend}
				${qtwebkitdepend}"
			;;
		optional)
			IUSE="${IUSE} webkit"
			qtdepend="${qtdepend}
				webkit? ( ${qtwebkitdepend} )
			"
			;;
		*) WEBKIT_REQUIRED="never" ;;
	esac
	# opengl dependencies
	case ${OPENGL_REQUIRED} in
		always)
			qtdepend="${qtdepend}
				${qtopengldepend}
			"
			;;
		optional)
			IUSE="${IUSE} opengl"
			qtdepend="${qtdepend}
				opengl? ( ${qtopengldepend} )
			"
			;;
		*) OPENGL_REQUIRED="never" ;;
	esac

	COMMONDEPEND="${COMMONDEPEND} ${qtdepend}"
}
kde4-base_set_qt_dependencies

# Xorg
COMMONDEPEND="${COMMONDEPEND}
	>=x11-base/xorg-server-1.5.2
"

# X11 libs
COMMONDEPEND="${COMMONDEPEND}
	x11-libs/libXext
	x11-libs/libXt
	x11-libs/libXxf86vm
"

# localization deps
# DISABLED UNTIL PMS decide correct approach :(
if [[ -n ${KDE_LINGUAS} ]]; then
	LNG_DEP=""
	for _lng in ${KDE_LINGUAS}; do
		# there must be or due to issue if lingua is not present in kde-l10n so
		# it wont die but pick kde-l10n as-is.
		LNG_DEP="${LNG_DEP}
			|| ( kde-base/kde-l10n[linguas_${_lng},kdeprefix=] kde-base/kde-l10n[kdeprefix=] )"
	done
fi

# Set common dependencies for all ebuilds that inherit this eclass
DEPEND="${DEPEND} ${COMMONDEPEND}
	>=dev-util/cmake-2.6.2
	dev-util/pkgconfig
	>=sys-apps/sandbox-1.3.2
"
RDEPEND="${RDEPEND} ${COMMONDEPEND}"

if [[ $BUILD_TYPE = live ]]; then
	# Disable tests for live ebuilds
	RESTRICT="${RESTRICT} test"
	# Live ebuilds in kde-base default to kdeprefix by default
	IUSE="${IUSE} +kdeprefix"
else
	# All other ebuild types default to -kdeprefix as before
	IUSE="${IUSE} kdeprefix"
fi

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

case ${CPPUNIT_REQUIRED} in
	always)
		DEPEND="${DEPEND}
			dev-util/cppunit
		"
		;;
	optional)
		IUSE="${IUSE} test"
		DEPEND="${DEPEND}
			test? ( dev-util/cppunit )
		"
		;;
	*)
		CPPUNIT_REQUIRED="never"
		;;
esac

# @ECLASS-VARIABLE: NEED_KDE
# @DESCRIPTION:
# This variable sets the version of KDE4 which will be used by the eclass.
# For kde-base packages, if it is not set by the ebuild,
# it's assumed that the required KDE4 version is the latest available.
# For non kde-base packages, it is also set to the latest by default.
#
# For more precise adjustments or for specifying particular kde version,
# KDE_MINIMAL variable can be used.
#
# @CODE
# Acceptable values are:
#	- latest - Use latest version in the portage tree
#		Default for kde-base ebuilds.
#	- live - Use live release (live ebuilds)
#	- none - Let the ebuild handle SLOT, kde dependencies, KDEDIR, ...
#	- 4.2, 4.1, kde-4 - respective slots for kde versions
# @CODE
# Note: default NEED_KDE is latest
NEED_KDE="${NEED_KDE:=latest}"
export NEED_KDE

# @ECLASS-VARIABLE: KDE_MINIMAL
# @DESCRIPTION:
# This wariable is used when NEED_KDE="latest" is set, to specify the
# required KDE minimal version for which apps will work.
# @CODE
# KDE_MINIMAL="-4.1"
# @CODE
# Note: default minimal version is kde-4.1, which means that the apps will work
# with any KDE version >=${KDE_MINIMAL}
KDE_MINIMAL="${KDE_MINIMAL:=4.2}"
export KDE_MINIMAL

# FIXME: the code section, explanation of live. The last sentence needs other
# formulation too.
#
# @ECLASS-VARIABLE: KDE_WANTED
# @DESCRIPTION:
# When NEED_KDE=latest is inherited, KDE_WANTED serves to indicate the prefered kde
# version. It's value is looked for before any other. Useful when having more
# +kdeprefix installs: you can choose which kde version, if present, to link
# against.
#
# @CODE
# Acceptable values are:
# 		stable = whatever is main tree (now 4.1)
# 		testing = whatever is in testing on main tree
# 		snapshot = whatever is released under snapshots (4.2 at present)
# 		live = live svn ebuilds, also default value, do not be scared it goes in this
#
# order: live->snapshot->testing->stable, when searching for kde. This way we
# allow users to use just kde4snapshots and use software from the tree.
KDE_WANTED="${KDE_WANTED:=live}"
export KDE_WANTED

case ${NEED_KDE} in
	latest)
		if [[ $KDEBASE = kde-base ]]; then
			case ${PV} in
				4.3* | 4.2.9* | 4.2.8* | 4.2.7* | 4.2.6*)
					_kdedir="4.3"
					_pv="-${PV}:4.3"
					_pvn="-${PV}"
					;;
				4.2* | 4.1.9* | 4.1.8* | 4.1.7* | 4.1.6*)
					_kdedir="4.2"
					_pv="-${PV}:4.2"
					_pvn="-${PV}"
					 ;;
				4.1*| 4.0.9* | 4.0.8*)
					_kdedir="4.1"
					_pv="-${PV}:4.1"
					_pvn="-${PV}"
					 ;;
				4.0*)
					_kdedir="4.0"
					_pv="-${PV}:kde-4"
					_pvn="-${PV}"
					;;
				3.9*)
					_kdedir="3.9"
					_pv="-${PV}:kde-4"
					_pvn="-${PV}"
					;;
				9999*)
					_kdedir="live"
					_pv="-${PV}:live"
					_pvn="-${PV}"
					;;
				*)
					die "NEED_KDE=latest not supported for PV=${PV}" ;;
			esac
			_operator=">="
		else
			# this creates dependency on any version of kde4
			_operator=">="
			_pv="-${KDE_MINIMAL}"
			_pvn=${_pv}
		fi
		;;

	# NEED_KDE="${PV}"
	scm|svn|live|9999*)
		_kdedir="live"
		_operator=">="
		_pv="-${NEED_KDE}:live"
		_pvn="-${NEED_KDE}"
		export NEED_KDE="live"
		;;
	4.3 | 4.2.9* | 4.2.8* | 4.2.7* | 4.2.6*)
		_kdedir="4.3"
		_pv="-${NEED_KDE}:4.3"
		_pvn="-${NEED_KDE}"
		_operator=">="
		;;
	4.2 | 4.1.9* | 4.1.8* | 4.1.7* | 4.1.6*)
		_kdedir="4.2"
		_pv="-${NEED_KDE}:4.2"
		_pvn="-${NEED_KDE}"
		_operator=">="
		;;
	4.1 | 4.0.9* | 4.0.8*)
		_kdedir="4.1"
		_pv="-${NEED_KDE}:4.1"
		_pvn="-${NEED_KDE}"
		_operator=">="
		;;
	4.0* | 4)
		_kdedir="4.0"
		_operator=">="
		_pv="-${NEED_KDE}:kde-4"
		_pvn="-${NEED_KDE}"
		;;
	3.9*)
		_kdedir="3.9"
		_operator=">="
		_pv="-${NEED_KDE}:kde-4"
		_pvn="-${NEED_KDE}"
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
		if [[ ${NEED_KDE} = live ]]; then
			SLOT="live"
		else
			case ${KMNAME} in
				koffice)
					case ${PV} in
						9999*) SLOT="live" ;;
						*) SLOT="2" ;;
					esac
					;;
				kdevelop)
					case ${PV} in
						9999*) SLOT="live" ;;
						4.0*|3.9*) SLOT="4" ;;
					esac
					;;
				kdevplatform)
					case ${PV} in
						9999*) SLOT="live" ;;
						1.0*|0.9*) SLOT="1" ;;
					esac
					;;
				*)
					case ${PV} in
						9999*) SLOT="live" ;;
						4.3* | 4.2.9* | 4.2.8* | 4.2.7* | 4.2.6*) SLOT="4.3" ;;
						4.2* | 4.1.9* | 4.1.8* | 4.1.7* | 4.1.6*) SLOT="4.2" ;;
						4.1* | 4.0.9* | 4.0.8*) SLOT="4.1" ;;
						*) SLOT="4.1" ;;
					esac
					;;
			esac
		fi
	fi

	# Block installation of other SLOTS unless kdeprefix
	for KDE_SLOT in ${KDE_SLOTS[@]}; do
		# block non kdeprefix ${PN} on other slots
		# we do this only if we do not depend on any version of kde
		if [[ ${SLOT} != ${KDE_SLOT} ]]; then
			DEPEND="${DEPEND}
				!kdeprefix? ( !kde-base/${PN}:${KDE_SLOT}[-kdeprefix] )
			"
			RDEPEND="${RDEPEND}
				!kdeprefix? ( !kde-base/${PN}:${KDE_SLOT}[-kdeprefix] )
			"
		fi
	done

	# Adding kdelibs and kdebase-data deps to all other packages.
	if [[ ${PN} != kdelibs ]]; then
		DEPEND="${DEPEND}
			kdeprefix? ( ${_operator}kde-base/kdelibs${_pv}[kdeprefix] )
			!kdeprefix? ( ${_operator}kde-base/kdelibs${_pvn}[-kdeprefix] )
		"
		RDEPEND="${RDEPEND}
			kdeprefix? ( ${_operator}kde-base/kdelibs${_pv}[kdeprefix] )
			!kdeprefix? ( ${_operator}kde-base/kdelibs${_pvn}[-kdeprefix] )
		"
		if [[ ${PN} != kdepimlibs && ${PN} != kdebase-data ]]; then
			RDEPEND="${RDEPEND}
				kdeprefix? ( ${_operator}kde-base/kdebase-data${_pv}[kdeprefix] )
				!kdeprefix? ( ${_operator}kde-base/kdebase-data${_pvn}[-kdeprefix] )
			"
		fi
	fi
	unset _operator _pv _pvn
fi

# Fetch section - If the ebuild's category is not 'kde-base' and if it is not a
# koffice ebuild, the URI should be set in the ebuild itself
case ${BUILD_TYPE} in
	live)
		SRC_URI=""
		ESVN_MIRROR=${ESVN_MIRROR:=svn://anonsvn.kde.org/home/kde}
		# Split ebuild, or extragear stuff
		if [[ -n ${KMNAME} ]]; then
		    ESVN_PROJECT="${KMNAME}"
			if [[ -z ${KMNOMODULE} && -z ${KMMODULE} ]]; then
				KMMODULE="${PN}"
			fi
			# Split kde-base/ ebuilds: (they reside in trunk/KDE)
			case ${KMNAME} in
				kdebase-*)
					ESVN_REPO_URI="${ESVN_MIRROR}/trunk/KDE/kdebase/${KMNAME#kdebase-}"
					;;
				kdereview)
					ESVN_REPO_URI="${ESVN_MIRROR}/trunk/${KMNAME}/${KMMODULE}"
					;;
				kde*)
					ESVN_REPO_URI="${ESVN_MIRROR}/trunk/KDE/${KMNAME}"
					;;
				extragear*|playground*)
					ESVN_REPO_URI="${ESVN_MIRROR}/trunk/${KMNAME}/${KMMODULE}"
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
			ESVN_REPO_URI="${ESVN_MIRROR}/trunk/KDE/${PN}"
			ESVN_PROJECT="${PN}"
		fi
		# limit syncing to 1 hour.
		ESVN_UP_FREQ=${ESVN_UP_FREQ:-1}
		;;
	*)
		if [[ -n ${KDEBASE} ]]; then
			if [[ -n ${KMNAME} ]]; then
				case ${KMNAME} in
					kdebase-apps)
						_kmname="kdebase" ;;
					*)
						_kmname=${KMNAME} ;;
				esac
			else
				_kmname=${PN}
			fi
			_kmname_pv="${_kmname}-${PV}"
			if [[ $NEED_KDE != live ]]; then
			case ${KDEBASE} in
				kde-base)
					case ${PV} in
						4.2.9* | 4.2.8* | 4.2.7* | 4.2.6*)
							SRC_URI="http://dev.gentooexperimental.org/~alexxy/kde/${PV}/${_kmname_pv}.tar.lzma" ;;
						4.1.9* | 4.1.8* | 4.1.7* | 4.1.6* | 4.0.9* | 4.0.8*)
							SRC_URI="mirror://kde/unstable/${PV}/src/${_kmname_pv}.tar.bz2" ;;
						*)	SRC_URI="mirror://kde/stable/${PV}/src/${_kmname_pv}.tar.bz2" ;;
					esac
					;;
				koffice)
					SRC_URI="mirror://kde/unstable/${_kmname_pv}/src/${_kmname_pv}.tar.bz2"
				;;
			esac
			fi
			unset _kmname _kmname_pv
		fi
		;;
esac

debug-print "${LINENO} ${ECLASS} ${FUNCNAME}: SRC_URI is ${SRC_URI}"

# @ECLASS-VARIABLE: PREFIX
# @DESCRIPTION:
# Set the installation PREFIX. All kde-base ebuilds go into the KDE4 installation directory.
# Applications installed by the other ebuilds go into ${KDEDIR} by default, this value
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
	debug-print-function ${FUNCNAME} "$@"

	# Don't set KDEHOME during compile, it will cause access violations
	unset KDEHOME

	# Search for best suitable kde installation for misc kde package.
	# Computation based on NEED_KDE and KDE_MINIMAL
	[[ ${KDEBASE} != kde-base ]] && [[ ${NEED_KDE} = latest || ${NEED_KDE} = none ]] && get_latest_kdedir

	# Set PREFIX
	if use kdeprefix; then
		KDEDIR="/usr/kde/${_kdedir}"
		KDEDIRS="/usr/local/:/usr:${KDEDIR}"
	else
		KDEDIR="/usr"
		KDEDIRS="/usr/local/:/usr"
	fi
	# Set the prefix based on KDEDIR
	# Make it a consequence of kdeprefix
	PREFIX=${KDEDIR}

	unset _kdedir

	# check if qt has correct deps
	[[ -n ${QT4_BUILT_WITH_USE_CHECK} || -n ${KDE4_BUILT_WITH_USE_CHECK[@]} ]] && \
		die "built_with_use illegal in this EAPI!"

	if [[ ${BUILD_TYPE} = live && -z ${I_KNOW_WHAT_I_AM_DOING} ]]; then
		echo
		elog "WARNING! This is an experimental live ebuild of ${KMNAME:-${PN}}"
		elog "Use it at your own risk."
		elog "Do _NOT_ file bugs at bugs.gentoo.org because of this ebuild!"
		echo
	fi
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

# @FUNCTION: kde4-base_src_compile
# @DESCRIPTION:
# General pre-configure and pre-compile function for KDE4 applications.
# It also handles translations if KDE_LINGUAS is defined. See KDE_LINGUAS and
# enable_selected_linguas() in kde4-functions.eclass(5) for further details.
kde4-base_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	# Only enable selected languages, used for KDE extragear apps.
	if [[ -n ${KDE_LINGUAS} ]]; then
		enable_selected_linguas
	fi

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

	 # Enable generation of HTML handbook
	if has htmlhandbook ${IUSE//+} && use htmlhandbook; then
		ebegin "Enabling building of HTML handbook"
		mycmakeargs="${mycmakeargs} -DKDE4_ENABLE_HTMLHANDBOOK=ON"
		eend $?
	fi

	# Build tests in src_test only, where we override this value
	mycmakeargs="${mycmakeargs} -DKDE4_BUILD_TESTS=OFF"

	# Set distribution name
	[[ ${PN} = kdelibs ]] && mycmakeargs="${mycmakeargs} -DKDE_DISTRIBUTION_TEXT=Gentoo"

	# runpath linking
	mycmakeargs="${mycmakeargs} -DKDE4_USE_ALWAYS_FULL_RPATH=ON"

	# Here we set the install prefix
	mycmakeargs="${mycmakeargs} -DCMAKE_INSTALL_PREFIX=${PREFIX}"

	# If prefix is /usr, sysconf needs to be /etc, not /usr/etc
	use kdeprefix || mycmakeargs="${mycmakeargs} -DSYSCONF_INSTALL_DIR=/etc"

	# Set environment
	QTEST_COLORED=1
	QT_PLUGIN_PATH="${KDEDIR}/$(get_libdir)/kde4/plugins/"

	# Hardcode path to *.pc KDE files
	export PKG_CONFIG_PATH="${PKG_CONFIG_PATH:+${PKG_CONFIG_PATH}:}${KDEDIR}/$(get_libdir)/pkgconfig"

	# Override some environment variables
	PATH="${KDEDIR}/bin:${PATH}"
	LDPATH="${KDEDIR}/$(get_libdir):${LDPATH}"

	# Set cmake prefixes to allow buildsystem to localize valid KDE installation when more are present
	if use kdeprefix; then
		mycmakeargs="${mycmakeargs}
			-DCMAKE_SYSTEM_INCLUDE_PATH=${KDEDIR}/include
			-DCMAKE_SYSTEM_LIBRARY_PATH=${KDEDIR}/$(get_libdir)
			-DCMAKE_SYSTEM_PREFIX_PATH=${KDEDIR}
			-DCMAKE_SYSTEM_PROGRAM_PATH=${KDEDIR}/bin"
	fi

	[ -e CMakeLists.txt ] && cmake-utils_src_configure
}

# @FUNCTION: kde4-base_src_compile
# @DESCRIPTION:
# General function for compiling KDE4 applications.
kde4-base_src_compile() {
	debug-print-function ${FUNCNAME} "$@"

	kde4-base_src_make
}

# @FUNCTION: kde4-base_src_make
# @DESCRIPTION:
# Function for building KDE4 applications.
# Options are passed to cmake-utils_src_make.
kde4-base_src_make() {
	debug-print-function ${FUNCNAME} "$@"

	if [[ -d "$WORKDIR/${PN}_build" ]]; then
		pushd "${WORKDIR}/${PN}_build" > /dev/null
	fi
	[ -e [Mm]akefile ] && cmake-utils_src_make "$@"
}

# @FUNCTION: kde4-base_src_test
# @DESCRIPTION:
# Function for testing KDE4 applications.
kde4-base_src_test() {
	debug-print-function ${FUNCNAME} "$@"

	# Override this value, set in kde4-base_src_configure()
	mycmakeargs="${mycmakeargs} -DKDE4_BUILD_TESTS=ON"
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
	if [[ -d "$WORKDIR/${PN}_build" ]]; then
		pushd "${WORKDIR}/${PN}_build" > /dev/null
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

	if [[ -n ${KDEBASE} && -d "${D}/usr/share/doc/${PF}" ]]; then
		# work around bug #97196
		dodir /usr/share/doc/kde && \
			mv "${D}/usr/share/doc/${PF}" "${D}"/usr/share/doc/kde/ || \
			die "Failed to move docs to kde/ failed."
	fi
}

# @FUNCTION: kde4-base_pkg_postinst
# @DESCRIPTION:
# Function to rebuild the KDE System Configuration Cache after an application has been installed.
kde4-base_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	buildsycoca
}

# @FUNCTION: kde4-base_pkg_postrm
# @DESCRIPTION:
# Function to rebuild the KDE System Configuration Cache after an application has been removed.
kde4-base_pkg_postrm() {
	debug-print-function ${FUNCNAME} "$@"

	buildsycoca
}
