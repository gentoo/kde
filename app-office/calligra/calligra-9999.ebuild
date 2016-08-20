# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

CHECKREQS_DISK_BUILD="4G"
KDE_HANDBOOK="forceoptional"
KDE_TEST="forceoptional"
inherit check-reqs kde5 versionator

DESCRIPTION="KDE Office Suite"
HOMEPAGE="http://www.calligra.org/"

case ${PV} in
	3.[0123456789].[789]?)
		# beta or rc releases
		SRC_URI="mirror://kde/unstable/${P}/${P}.tar.xz" ;;
	3.[0123456789].?)
		# stable releases
		SRC_URI="mirror://kde/stable/${P}/${P}.tar.xz"
esac

LICENSE="GPL-2"

[[ ${KDE_BUILD_TYPE} == release ]] && \
KEYWORDS="~amd64 ~x86"

IUSE="activities +crypt +eigen +fontconfig gsl import-filter +lcms kdepim
	marble okular openexr +pdf spacenav +truetype vc +webkit +xml X"

# Don't use Active, it's broken on desktops.
CAL_FTS="author braindump karbon plan sheets stage words"
for cal_ft in ${CAL_FTS}; do
	IUSE+=" calligra_features_${cal_ft}"
done
unset cal_ft

REQUIRED_USE="
	calligra_features_author? ( calligra_features_words )
	calligra_features_sheets? ( eigen )
	calligra_features_stage? ( webkit )
	test? ( calligra_features_karbon )
"

# drop qtcore subslot operator when QT_MINIMAL >= 5.7.0
COMMON_DEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep kemoticons)
	$(add_frameworks_dep kglobalaccel)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemmodels)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep knotifyconfig)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kross)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwallet)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep sonnet)
	$(add_frameworks_dep threadweaver)
	$(add_qt_dep designer)
	$(add_qt_dep qtconcurrent)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtdeclarative)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtprintsupport)
	$(add_qt_dep qtscript)
	$(add_qt_dep qtsvg)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtxml)
	dev-lang/perl
	dev-libs/boost
	media-libs/libpng:0
	sys-libs/zlib
	virtual/libiconv
	activities? ( $(add_frameworks_dep kactivities) )
	crypt? ( app-crypt/qca:2[qt5] )
	eigen? ( dev-cpp/eigen:3 )
	fontconfig? ( media-libs/fontconfig )
	gsl? ( sci-libs/gsl )
	import-filter? (
		$(add_frameworks_dep khtml)
		app-text/libetonyek
		app-text/libodfgen
		app-text/libwpd:*
		app-text/libwpg:*
		app-text/libwps
		dev-libs/librevenge
		media-libs/libvisio
	)
	lcms? ( media-libs/lcms:2 )
	marble? ( $(add_kdeapps_dep marble) )
	openexr? ( media-libs/openexr )
	pdf? ( app-text/poppler:=[qt5] )
	spacenav? ( dev-libs/libspnav )
	truetype? ( media-libs/freetype:2 )
	X? (
		$(add_qt_dep qtx11extras)
		x11-libs/libX11
	)
	calligra_features_braindump? ( webkit? ( $(add_qt_dep qtwebkit) ) )
	calligra_features_plan? (
		$(add_qt_dep qtcore '' '' '5=')
		$(add_kdeapps_dep kdiagram)
		$(add_kdeapps_dep kproperty)
		$(add_kdeapps_dep kreport)
		kdepim? (
			$(add_kdeapps_dep akonadi)
			$(add_kdeapps_dep akonadi-contacts)
			$(add_kdeapps_dep kcalcore)
			$(add_kdeapps_dep kcontacts)
			$(add_kdeapps_dep kdgantt2)
		)
	)
	calligra_features_stage? (
		$(add_qt_dep qtwebkit)
		okular? ( $(add_kdeapps_dep okular) )
	)
	calligra_features_words? (
		dev-libs/libxslt
		okular? ( $(add_kdeapps_dep okular) )
	)
"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
	x11-misc/shared-mime-info
	vc? ( >=dev-libs/vc-1.1.0 )
"
RDEPEND="${COMMON_DEPEND}
	calligra_features_karbon? ( media-gfx/pstoedit[plotutils] )
	!app-office/calligra:4
"

#[[ ${PV} == 9999 ]] && LANGVERSION="3.0" || LANGVERSION="$(get_version_component_range 1-2)"
#PDEPEND=">=app-office/calligra-l10n-${LANGVERSION}"

pkg_pretend() {
	check-reqs_pkg_pretend
}

pkg_setup() {
	kde5_pkg_setup
	check-reqs_pkg_setup
}

src_prepare() {
	kde5_src_prepare

	# Unconditionally disable deprecated deps (required by QtQuick1)
	punt_bogus_dep Qt5 Declarative
	punt_bogus_dep Qt5 OpenGL

	if ! use webkit; then
		punt_bogus_dep Qt5 WebKitWidgets
		punt_bogus_dep Qt5 WebKit
	fi

	# Hack around the excessive use of CMake macros
	if use okular && ! use calligra_features_words; then
		sed -i -e "/add_subdirectory( *okularodtgenerator *)/ s/^/#DONT/" \
			extras/CMakeLists.txt || die "Failed to disable OKULAR_GENERATOR_ODT"
	fi

	if use okular && ! use calligra_features_stage; then
		sed -i -e "/add_subdirectory( *okularodpgenerator *)/ s/^/#DONT/" \
			extras/CMakeLists.txt || die "Failed to disable OKULAR_GENERATOR_ODP"
	fi
}

src_configure() {
	local cal_ft myproducts

	# applications
	for cal_ft in ${CAL_FTS}; do
		local prod=${cal_ft^^}
		if use calligra_features_${cal_ft} ; then
			myproducts+=( "${prod}" )
		fi
	done

	local mycmakeargs=( -DPRODUCTSET="${myproducts[*]}" )

	mycmakeargs+=(
		-DPACKAGERS_BUILD=OFF
		-DWITH_Iconv=ON
		-DWITH_Qca-qt5=$(usex crypt)
		-DWITH_Eigen3=$(usex eigen)
		-DWITH_Fontconfig=$(usex fontconfig)
		-DWITH_GSL=$(usex gsl)
		-DWITH_LibEtonyek=$(usex import-filter)
		-DWITH_LibOdfGen=$(usex import-filter)
		-DWITH_LibRevenge=$(usex import-filter)
		-DWITH_LibVisio=$(usex import-filter)
		-DWITH_LibWpd=$(usex import-filter)
		-DWITH_LibWpg=$(usex import-filter)
		-DWITH_LibWps=$(usex import-filter)
		$(cmake-utils_use_find_package kdepim KF5Akonadi)
		$(cmake-utils_use_find_package kdepim KF5AkonadiContact)
		$(cmake-utils_use_find_package kdepim KF5CalendarCore)
		$(cmake-utils_use_find_package kdepim KF5Contacts)
		$(cmake-utils_use_find_package kdepim KGantt)
		-DWITH_LCMS2=$(usex lcms)
		-DWITH_CalligraMarble=$(usex marble)
		-DWITH_Okular5=$(usex okular)
		-DWITH_OpenEXR=$(usex openexr)
		-DWITH_Poppler=$(usex pdf)
		-DWITH_Spnav=$(usex spacenav)
		-ENABLE_CSTESTER_TESTING=$(usex test)
		-DWITH_Freetype=$(usex truetype)
		-DWITH_Vc=$(usex vc)
		-DCMAKE_DISABLE_FIND_PACKAGE_Libgit2=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_Libqgit2=ON
	)

	kde5_src_configure
}
