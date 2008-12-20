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
# NOTE: This eclass NEEDS EAPI="2" or greater defined in ebuild.

inherit base cmake-utils eutils multilib kde4-functions
#live/normal
get_build_type
if [[ "${BUILD_TYPE}" == "live" ]]; then
	inherit subversion
fi

EXPORT_FUNCTIONS pkg_setup src_unpack src_prepare src_configure src_compile src_test src_install pkg_postinst pkg_postrm

# Set the qt dependencies
kde4-base_set_qt_dependencies() {
	local qt qtcore qtgui qt3support qtdepend qtopengldepend

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

	# split qt
	qtdepend="
		x11-libs/qt-core:4${qtcore}
		x11-libs/qt-gui:4${qtgui}
		x11-libs/qt-qt3support:4${qt3support}
		x11-libs/qt-script:4
		x11-libs/qt-svg:4
		x11-libs/qt-test:4"
	qtopengldepend="x11-libs/qt-opengl:4"

	# KDE > 4.1.71 needs qt-webkit
	case "${PV}" in
		scm|9999*|4.2*|4.1.9*|4.1.8*|4.1.7*)
			qtdepend="${qtdepend}
				x11-libs/qt-webkit:4"
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

	COMMONDEPEND="${COMMONDEPEND} ${qtdepend} !x11-libs/qt-phonon"
}
kde4-base_set_qt_dependencies

# Set the cmake dependencies
case "${PV}" in
	9999*)
		CMAKEDEPEND=">=dev-util/cmake-2.6.2"
		;;
	4.2*|4.1.9*|4.1.8*|4.1.7*|4.1.6*)
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
IUSE="${IUSE} kdeprefix"

# Do not allow to run test on live ebuilds
if [[ "${BUILD_TYPE}" == "live" ]]; then
	RESTRICT="${RESTRICT} test"
fi

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
NEED_KDE="${NEED_KDE:-latest}"
export NEED_KDE

# FIXME: look at the description, please, somehow illegible
# @ECLASS-VARIABLE: KDE_MINIMAL
# @DESCRIPTION:
# This wariable is used when NEED_KDE="latest" is set,
# to specify minimal version with which apps will work.
# it is used in set manner.
# @CODE
# KDE_MINIMAL="-4.1"
# specify minimal version as kde-4.1, can be mostly anything which can be put as
# >=${PN}-${KDE_MINIMAL}
KDE_MINIMAL="${KDE_MINIMAL:-3.9}"
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
if [[ -z ${KDE_WANTED} ]]; then
	KDE_WANTED="live"
fi
export KDE_WANTED

case ${NEED_KDE} in
	latest)
		if [[ "${KDEBASE}" == "kde-base" ]]; then
			case ${PV} in
				4.2* | 4.1.9* | 4.1.8* | 4.1.7* | 4.1.6*)
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
				9999*)
					_kdedir="live"
					_pv="-${PV}:live" ;;
				*)
					die "NEED_KDE=latest not supported for PV=${PV}" ;;
				esac
			_operator=">="
		else
			# this creates dependency on any version of kde4
			_operator=">="
			_pv="-${KDE_MINIMAL}"
		fi
		;;

	# NEED_KDE="${PV}"
	scm|svn|live|9999*)
		_kdedir="live"
		_operator=">="
		_pv="-${NEED_KDE}:live"
		export NEED_KDE="live"
		;;
	4.2 | 4.1.9* | 4.1.8* | 4.1.7* | 4.1.6*)
		_kdedir="4.2"
		_operator=">="
		_pv="-${NEED_KDE}:4.2"
		;;
	4.1 | 4.0.9* | 4.0.8*)
		_kdedir="4.1"
		_operator=">="
		_pv="-${NEED_KDE}:4.1"
		;;
	4.0* | 4)
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
						4.2* | 4.1.9* | 4.1.8* | 4.1.7* | 4.1.6*) SLOT="4.2" ;;
						4.1* | 4.0.9* | 4.0.8*) SLOT="4.1" ;;
						*) SLOT="kde-4" ;;
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
				!kdeprefix? ( !kde-base/${PN}:${KDE_SLOT}[-kdeprefix] )"
			RDEPEND="${RDEPEND}
				!kdeprefix? ( !kde-base/${PN}:${KDE_SLOT}[-kdeprefix] )"
		fi
	done

	# Adding kdelibs, kdepimlibs and kdebase-data deps to all other packages.
	# We only need to add the dependencies if ${PN} is not "kdelibs" or "kdepimlibs"
	if [[ ${PN} != "kdelibs" ]]; then
		DEPEND="${DEPEND} ${_operator}kde-base/kdelibs${_pv}[kdeprefix=]"
		RDEPEND="${RDEPEND}	${_operator}kde-base/kdelibs${_pv}[kdeprefix=]"
		if [[ ${PN} != "kdepimlibs" ]]; then
			DEPEND="${DEPEND} ${_operator}kde-base/kdepimlibs${_pv}[kdeprefix=]"
			RDEPEND="${RDEPEND} ${_operator}kde-base/kdepimlibs${_pv}[kdeprefix=]"
			if [[ ${PN} != "kdebase-data" ]]; then
				RDEPEND="${RDEPEND} ${_operator}kde-base/kdebase-data${_pv}[kdeprefix=]"
			fi
		fi
	fi
	unset _operator _pv
fi

# Fetch section - If the ebuild's category is not 'kde-base' and if it is not a
# koffice ebuild, the URI should be set in the ebuild itself
case ${SLOT} in
	live)
		ESVN_MIRROR=${ESVN_MIRROR:-svn://anonsvn.kde.org/home/kde}
		# Split ebuild, or extragear stuff
		if [[ -n ${KMNAME} ]]; then
		    ESVN_PROJECT="KDE/${KMNAME}"
			if [[ -z ${KMNOMODULE} && -z ${KMMODULE} ]]; then
				KMMODULE="${PN}/"
			fi
			# Split kde-base/ ebuilds: (they reside in trunk/KDE)
			case ${KMNAME} in
				kdebase-*)
					ESVN_REPO_URI="${ESVN_MIRROR}/trunk/KDE/kdebase"
					ESVN_PROJECT="KDE/kdebase"
					;;
				kdereview)
					ESVN_REPO_URI="${ESVN_MIRROR}/trunk/${KMNAME}/${KMMODULE}"
					;;
				kde*)
					ESVN_REPO_URI="${ESVN_MIRROR}/trunk/KDE/${KMNAME}"
					;;
				extragear*|playground*)
					case ${PN} in
						*-plasma)
							ESVN_REPO_URI="${ESVN_MIRROR}/trunk/${KMNAME}/${KMMODULE}"
							ESVN_PROJECT="KDE/${KMNAME}/${KMMODULE}"
							;;
						*)
							ESVN_REPO_URI="${ESVN_MIRROR}/trunk/${KMNAME}/${KMMODULE}"
							;;
					esac
				;;
				koffice)
					ESVN_REPO_URI="${ESVN_MIRROR}/trunk/${KMNAME}"
					;;
				*)
					# Extragear material
					ESVN_REPO_URI="${ESVN_MIRROR}/trunk/${KMNAME}/${KMMODULE}/"
					;;
			esac
		else
			# kdelibs, kdepimlibs
			ESVN_REPO_URI="${ESVN_MIRROR}/trunk/KDE/${PN}"
			ESVN_PROJECT="KDE/${PN}"
		fi
		# limit syncing to 1 hour.
		ESVN_UP_FREQ=${ESVN_UP_FREQ:-1}
	;;
	*)
		if [[ -n ${KDEBASE} ]]; then
			if [[ -n ${KMNAME} ]]; then
				_kmname=${KMNAME}
			else
				_kmname=${PN}
			fi
			_kmname_pv="${_kmname}-${PV}"
			if [[ ${NEED_KDE} != "live" ]]; then
			case ${KDEBASE} in
				kde-base)
					case ${PV} in
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
	debug-print-function $FUNCNAME "$@"

	# Don't set KDEHOME during compile, it will cause access violations
	unset KDEHOME

	# Search for best suitable kde installation for misc kde package.
	# Computation based on NEED_KDE and KDE_MINIMAL
	get_latest_kdedir

	if [[ ${NEED_KDE} != none ]]; then
		# Set PREFIX
		if use kdeprefix; then
			KDEDIR="/usr/kde/${_kdedir}"
			KDEDIRS="/usr/local/:/usr:${KDEDIR}"
		else
			KDEDIR="/usr"
			KDEDIRS="/usr/local/:/usr"
		fi
	fi
	# Set the prefix based on KDEDIR
	# Make it a consequence of kdeprefix
	PREFIX=${KDEDIR}

	unset _kdedir

	# FIXME: reformulate, please
	# check if useflags were checked. (ugly description i know...)
	[[ -n ${QT4_BUILT_WITH_USE_CHECK} || -n ${KDE4_BUILT_WITH_USE_CHECK[@]} ]] && \
		die "built_with_use illegal in this EAPI!"

	if [[ ${SLOT} == "live" || ${PV} == "9999*" ]]; then
		if [[ -z ${I_KNOW_WHAT_I_AM_DOING} ]]; then
			elog
			elog "WARNING! This is an experimental ebuild of the ${KMNAME:-${PN}} KDE4 SVN tree."
			elog "Use at your own risk. Do _NOT_ file bugs at bugs.gentoo.org because"
			elog "of this ebuild!"
		fi
	fi
}

# @FUNCTION: kde4-base_src_unpack
# @DESCRIPTION:
# This function unpacks the source tarballs for KDE4 applications.
#
# If no argument is passed to this function, then standard src_unpack is
# executed. Otherwise, options are passed to base_src_unpack.
kde4-base_src_unpack() {
	debug-print-function $FUNCNAME "$@"

	if [[ "${BUILD_TYPE}" == "live" ]]; then
		local cleandir
		cleandir="${ESVN_STORE_DIR}/KDE/KDE"
		if [[ -d ${cleandir} ]]; then
			eerror "'${cleandir}' should never have been created. Either move it to"
			eerror "${ESVN_STORE_DIR}/${ESVN_PROJECT}/${ESVN_REPO_URI##*/} or remove"
			eerror "completely."
			die "'${cleandir}' is in the way."
		fi
		subversion_src_unpack
	else	
		[[ -z "${KDE_S}" ]] && KDE_S="${S}"
		if [[ -z $* ]]; then
			# Unpack first and deal with KDE patches after examing possible patch sets.
			# To be picked up, patches need to conform to the guidelines stated before.
			# Monolithic ebuilds will use the split ebuild patches.
			[[ -d "${KDE_S}" ]] || unpack ${A}
		fi
		# Updated cmake dir
		if [[ -d "${WORKDIR}/cmake" ]] && [[ -d "${KDE_S}/cmake" ]]; then
			ebegin "Updating cmake/ directory..."
			rm -rf "${KDE_S}/cmake" || die "Unable to remove old cmake/ directory"
			ln -s "${WORKDIR}/cmake" "${KDE_S}/cmake" || die "Unable to symlink the new cmake/ directory"
			eend 0
		fi
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


	# Autopatch
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

	# We prefer KDE's own Debugfull mode over the standard Debug
	if has debug ${IUSE//+} && use debug ; then
		mycmakeargs="${mycmakeargs} -DCMAKE_BUILD_TYPE=Debugfull"
	fi

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
	use kdeprefix || mycmakeargs="${mycmakeargs} -DSYSCONF_INSTALL_DIR=/etc"

	# Set environment
	QTEST_COLORED=1
	QT_PLUGIN_PATH=${KDEDIR}/$(get_libdir)/kde4/plugins/

	# hardcode path to *.cmake KDE files
	PKG_CONFIG_PATH="${PKG_CONFIG_PATH:+${PKG_CONFIG_PATH}:}${KDEDIR}/$(get_libdir)/pkgconfig"

	# additonal arguments for KOFFICE
	if [[ "${KMNAME}" == "koffice" ]]; then
		case ${PN} in
			koffice-data) : ;;
			*)
				mycmakeargs="${mycmakeargs}
					-DWITH_OpenEXR=ON
					$(cmake-utils_use_with crypt QCA2)
					$(cmake-utils_use_with opengl OpenGL)"
				if use crypt; then
					mycmakeargs="${mycmakeargs}
						-DQCA2_LIBRARIES=/usr/$(get_libdir)/qca2/libqca.so.2"
				fi
				;;
		esac
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

	if [[ -d ${WORKDIR}/${PN}_build ]]; then
		pushd "${WORKDIR}"/${PN}_build > /dev/null
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
	cmake-utils_src_compile

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
