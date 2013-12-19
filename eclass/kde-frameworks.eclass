# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# @ECLASS: kde-frameworks.eclass
# @MAINTAINER:
# kde@gentoo.org
# @BLURB: Support eclass for KDE Frameworks
# @DESCRIPTION:
# The kde-frameworks.eclass provides support for building KDE Frameworks.

if [[ ${___ECLASS_ONCE_KDE_FRAMEWORKS} != "recur -_+^+_- spank" ]] ; then
___ECLASS_ONCE_KDE_FRAMEWORKS="recur -_+^+_- spank"

CMAKE_MIN_VERSION="2.8.12"

# @ECLASS-VARIABLE: VIRTUALX_REQUIRED
# @DESCRIPTION:
# For proper description see virtualx.eclass manpage.
# Here we redefine default value to be manual, if your package needs virtualx
# for tests you should proceed with setting VIRTUALX_REQUIRED=test.
: ${VIRTUALX_REQUIRED:=manual}

inherit kde4-functions toolchain-funcs fdo-mime flag-o-matic gnome2-utils base virtualx versionator eutils multilib cmake-utils

if [[ ${KDE_BUILD_TYPE} = live ]]; then
	inherit git-r3
	EGIT_BRANCH="master"
fi

EXPORT_FUNCTIONS pkg_setup src_unpack src_prepare src_configure src_compile src_test src_install pkg_preinst pkg_postinst pkg_postrm

# @ECLASS-VARIABLE: QT_MINIMAL
# @DESCRIPTION:
# Determine version of qt we enforce as minimal for the package.
QT_MINIMAL="${QT_MINIMAL:-5.1.90}"

# @ECLASS-VARIABLE: FRAMEWORKS_DEBUG
# @DESCRIPTION:
# If set to "false", do nothing.
# For any other value, add debug to IUSE.
: ${FRAMEWORKS_DEBUG:=true}

# @ECLASS-VARIABLE: FRAMEWORKS_DOXYGEN
# @DESCRIPTION:
# If defined, add doc to IUSE, add a dependency on doxygen,
# and generate and install API documentation.

# @ECLASS-VARIABLE: FRAMEWORKS_EXAMPLES
# @DESCRIPTION:
# If set to "false", do nothing.
# For any other value, add examples to IUSE.
: ${FRAMEWORKS_EXAMPLES:=false}

# @ECLASS-VARIABLE: FRAMEWORKS_TEST
# @DESCRIPTION:
# If set to "false", do nothing.
# For any other value, add test to IUSE and add a dependency on qttest.
: ${FRAMEWORKS_TEST:=true}

HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"

SLOT=5

COMMONDEPEND+="
	>=dev-qt/qtcore-${QT_MINIMAL}:5
"
DEPEND+="dev-libs/extra-cmake-modules"

if [[ -n "${FRAMEWORKS_DOXYGEN}" ]]; then
	IUSE+=" doc"
	DEPEND+=" doc? ( app-doc/doxygen )"
fi

case ${FRAMEWORKS_DEBUG} in
	false)	;;
	*)
		IUSE+=" debug"
		;;
esac

case ${FRAMEWORKS_EXAMPLES} in
	false)  ;;
	*)
		IUSE+=" examples"
		;;
esac

case ${FRAMEWORKS_TEST} in
	false)	;;
	*)
		IUSE+=" test"
		DEPEND+=" test? ( dev-qt/qttest:5 )"
		;;
esac

DEPEND+=" ${COMMONDEPEND}"
RDEPEND+=" ${COMMONDEPEND}"
unset COMMONDEPEND

# Determine fetch location for released tarballs
_calculate_src_uri() {
	debug-print-function ${FUNCNAME} "$@"

	die "not implemented yet"
}

# Determine fetch location for live sources
_calculate_live_repo() {
	debug-print-function ${FUNCNAME} "$@"

	SRC_URI=""

	local _kmname
	# @ECLASS-VARIABLE: EGIT_MIRROR
	# @DESCRIPTION:
	# This variable allows easy overriding of default kde mirror service
	# (anongit) with anything else you might want to use.
	EGIT_MIRROR=${EGIT_MIRROR:=git://anongit.kde.org}

	# @ECLASS-VARIABLE: EGIT_REPONAME
	# @DESCRIPTION:
	# This variable allows overriding of default repository
	# name. Specify only if this differ from PN and KMNAME.
	if [[ -n ${EGIT_REPONAME} ]]; then
		# the repository and kmname different
		_kmname=${EGIT_REPONAME}
	elif [[ -n ${KMNAME} ]]; then
		_kmname=${KMNAME}
	else
		_kmname=${PN}
	fi

	# default branching
	[[ ${PV} != 9999* && ${KDEBASE} == kde-base ]] && \
		EGIT_BRANCH="KDE/$(get_kde_version)"

	# default repo uri
	EGIT_REPO_URI="${EGIT_MIRROR}/${_kmname}"
}

case ${KDE_BUILD_TYPE} in
	live) _calculate_live_repo ;;
	*) _calculate_src_uri ;;
esac

debug-print "${LINENO} ${ECLASS} ${FUNCNAME}: SRC_URI is ${SRC_URI}"

# @ECLASS-VARIABLE: PREFIX
# @DESCRIPTION:
# Set the installation PREFIX for non kde-base applications. It defaults to /usr.
# kde-base packages go into KDE4 installation directory (/usr).
# No matter the PREFIX, package will be built against KDE installed in /usr.

# @FUNCTION: kde-frameworks_pkg_setup
# @DESCRIPTION:
# Do some basic settings
kde-frameworks_pkg_setup() {
	debug-print-function ${FUNCNAME} "$@"

	# Don't set KDEHOME during compilation, it will cause access violations
	unset KDEHOME

	# Check if gcc compiler is fresh enough.
	# In theory should be in pkg_pretend but we check it only for kdelibs there
	# and for others we do just quick scan in pkg_setup because pkg_pretend
	# executions consume quite some time.
	if [[ ${MERGE_TYPE} != binary ]]; then
		[[ $(gcc-major-version) -lt 4 ]] || \
				( [[ $(gcc-major-version) -eq 4 && $(gcc-minor-version) -le 5 ]] ) \
			&& die "Sorry, but gcc-4.5 or later is required for KDE frameworks."
	fi

	: ${PREFIX:=/usr}

	# Point to correct QT plugins path
	QT_PLUGIN_PATH="${EPREFIX}/usr/$(get_libdir)/kde4/plugins/"

	# Fix XDG collision with sandbox
	export XDG_CONFIG_HOME="${T}"
}

# @FUNCTION: kde-frameworks_src_unpack
# @DESCRIPTION:
# Function for unpacking KDE frameworks.
kde-frameworks_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

	if [[ ${KDE_BUILD_TYPE} = live ]]; then
		git-r3_src_unpack
	else
		unpack ${A}
	fi
}

# @FUNCTION: kde-frameworks_src_prepare
# @DESCRIPTION:
# Function for preparing the KDE frameworks sources.
kde-frameworks_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	# never build manual tests
	sed -e "/add_subdirectory[[:space:]]*([[:space:]]*tests[[:space:]]*)/s/^/#DONOTCOMPILE /" \
		-i CMakeLists.txt || die

	# only build examples when required
	if ! in_iuse examples || ! use examples ; then
		sed	-e "/add_subdirectory[[:space:]]*([[:space:]]*examples[[:space:]]*)/s/^/#DONOTCOMPILE /" \
			-i CMakeLists.txt || die
	fi

	# only build unit tests when required
	if ! in_iuse test || ! use test ; then
		sed -e "/add_subdirectory[[:space:]]*([[:space:]]*autotests[[:space:]]*)/s/^/#DONOTCOMPILE /" \
			-i CMakeLists.txt || die
	fi

	cmake-utils_src_prepare
}

# @FUNCTION: kde-frameworks_src_configure
# @DESCRIPTION:
# Function for configuring the build of KDE frameworks.
kde-frameworks_src_configure() {
	debug-print-function ${FUNCNAME} "$@"

	# we rely on cmake-utils.eclass to append -DNDEBUG too
	if ! use_if_iuse debug; then
		append-cppflags -DQT_NO_DEBUG
	fi

	# Here we set the install prefix
	tc-is-cross-compiler || cmakeargs+=(-DCMAKE_INSTALL_PREFIX="${EPREFIX}${PREFIX}")

	# Shadow existing installations
	unset KDEDIRS

	#qmake -query QT_INSTALL_LIBS unavailable when cross-compiling
	# todo: is this still relevant?
	tc-is-cross-compiler && cmakeargs+=(-DQT_LIBRARY_DIR=${ROOT}/usr/$(get_libdir)/qt4)
	#kde-config -path data unavailable when cross-compiling
	tc-is-cross-compiler && cmakeargs+=(-DKDE4_DATA_DIR=${ROOT}/usr/share/apps/)

	# sysconf needs to be /etc, not /usr/etc
	# todo: move this to frameworks that require it
	# currently tier2/kauth, but possibly more later
	cmakeargs+=(-DSYSCONF_INSTALL_DIR="${EPREFIX}"/etc)

	# to support slotting with KDE 4
	cmakeargs+=(
		-DBIN_INSTALL_DIR="${EPREFIX}"/usr/bin/kf5/
		-DINCLUDE_INSTALL_DIR="${EPREFIX}"/usr/include/kf5/
	)

	if ! use_if_iuse test ; then
		cmakeargs+=( -DBUILD_TESTING=OFF )
	fi

	# allow the ebuild to override what we set here
	mycmakeargs=("${cmakeargs[@]}" "${mycmakeargs[@]}")

	cmake-utils_src_configure
}

# @FUNCTION: kde-frameworks_src_compile
# @DESCRIPTION:
# Function for compiling KDE frameworks.
kde-frameworks_src_compile() {
	debug-print-function ${FUNCNAME} "$@"

	cmake-utils_src_compile "$@"

	# Build doxygen documentation if applicable
	if use_if_iuse doc ; then
		doxygen "${S}"
	fi
}

# @FUNCTION: kde-frameworks_src_test
# @DESCRIPTION:
# Function for testing KDE frameworks.
kde-frameworks_src_test() {
	debug-print-function ${FUNCNAME} "$@"

	_test_runner() {
		if [[ -n "${VIRTUALDBUS_TEST}" ]]; then
			export $(dbus-launch)
		fi

		cmake-utils_src_test
	}		

	# When run as normal user during ebuild development with the ebuild command, the
	# kde tests tend to access the session DBUS. This however is not possible in a real
	# emerge or on the tinderbox.
	# > make sure it does not happen, so bad tests can be recognized and disabled
	unset DBUS_SESSION_BUS_ADDRESS DBUS_SESSION_BUS_PID

	if [[ ${VIRTUALX_REQUIRED} == always || ${VIRTUALX_REQUIRED} == test ]]; then
		VIRTUALX_COMMAND="_test_runner" virtualmake
	else
		_test_runner
	fi

	if [ -n "${DBUS_SESSION_BUS_PID}" ] ; then
		kill ${DBUS_SESSION_BUS_PID}
	fi
}

# @FUNCTION: kde-frameworks_src_install
# @DESCRIPTION:
# Function for installing KDE frameworks.
kde-frameworks_src_install() {
	debug-print-function ${FUNCNAME} "$@"

	# Install common documentation
	local doc
	for doc in "${S}"/{AUTHORS,CHANGELOG,ChangeLog*,README*,NEWS,TODO,HACKING}; do
		[[ -f ${doc} && -s ${doc} ]] && dodoc "${doc}"
	done

	# Install doxygen documentation if applicable
	if use_if_iuse doc ; then
		dohtml -r html/*
	fi

	cmake-utils_src_install
}

# @FUNCTION: kde-frameworks_pkg_preinst
# @DESCRIPTION:
# Function storing icon caches
kde-frameworks_pkg_preinst() {
	debug-print-function ${FUNCNAME} "$@"

	gnome2_icon_savelist
}

# @FUNCTION: kde-frameworks_pkg_postinst
# @DESCRIPTION:
# Function to rebuild the KDE System Configuration Cache after an application has been installed.
kde-frameworks_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	gnome2_icon_cache_update
	fdo-mime_desktop_database_update
}

# @FUNCTION: kde-frameworks_pkg_postrm
# @DESCRIPTION:
# Function to rebuild the KDE System Configuration Cache after an application has been removed.
kde-frameworks_pkg_postrm() {
	debug-print-function ${FUNCNAME} "$@"

	gnome2_icon_cache_update
	fdo-mime_desktop_database_update
}

fi
