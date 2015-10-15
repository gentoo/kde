# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

#
# TODO: complete packaging of qtsoap and qtkoauth, see dilfridge overlay for work in progress
#

EAPI=5

if [[ ${KDE_BUILD_TYPE} != live ]]; then
KDE_HANDBOOK=true
fi

EGIT_BRANCH=frameworks
KDE_TEST=true
inherit flag-o-matic kde5

MY_PV=${PV/_/-}
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Plugins for the KDE Image Plugin Interface"
HOMEPAGE="http://www.digikam.org/"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="cdr calendar expoblending +imagemagick mediawiki opengl panorama vkontakte"

if [[ ${KDE_BUILD_TYPE} != live ]]; then
	LICENSE="${LICENSE} handbook? ( FDL-1.2 )"
	MY_PV=${PV/_/-}
	MY_P="digikam-${MY_PV}"
	SRC_URI="mirror://kde/stable/digikam/${MY_P}.tar.bz2"
	S=${WORKDIR}/${MY_P}/extra/${PN}
fi

# TODO: Add back when ported
# 	dev-libs/libxml2
# 	dev-libs/libxslt
# 	crypt? ( app-crypt/qca:2[qt5(+)] )
# 	redeyes? ( >=media-libs/opencv-2.4.9 )
# 	videoslideshow?	(
# 		>=media-libs/qt-gstreamer-0.9.0[qt5(+)]
# 		|| ( media-gfx/imagemagick media-gfx/graphicsmagick[imagemagick] )
# 	)

COMMONDEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep threadweaver)
	dev-libs/qjson
	dev-qt/qtconcurrent:5
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsvg:5
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	dev-qt/qtxmlpatterns:5
	kde-apps/libkexiv2:5=
	kde-apps/libkipi:5=
	media-libs/libpng:0=
	media-libs/tiff:0
	virtual/jpeg:0
	calendar? ( $(add_kdeapps_dep kcalcore) )
	mediawiki? ( net-libs/libmediawiki:5 )
	opengl? (
		dev-qt/qtopengl:5
		media-libs/phonon[qt5]
		x11-libs/libXrandr
		virtual/opengl
	)
	vkontakte? ( net-libs/libkvkontakte:5 )
"
DEPEND="${COMMONDEPEND}
	sys-devel/gettext
	panorama? (
		sys-devel/bison
		sys-devel/flex
	)
"
RDEPEND="${COMMONDEPEND}
	!media-plugins/kipi-plugins:4
	cdr? ( app-cdr/k3b )
	expoblending? ( media-gfx/hugin )
	imagemagick? ( || ( media-gfx/imagemagick media-gfx/graphicsmagick[imagemagick] ) )
	panorama? (
		media-gfx/enblend
		media-gfx/hugin
	)
"

RESTRICT=test

PATCHES=(
	"${FILESDIR}/${PN}-5.0.0-expoblending.patch"
	"${FILESDIR}/${PN}-5.0.0-jpeg.patch"
)

src_prepare() {
	undetect_lib() {
		local _use=${1}
		local _name=${2}
		[[ -z ${_name} ]] && _name=$(echo ${_use} | sed 's/./\U&/g')
		use $_use || \
			sed -i -e "/DETECT_LIB${_name}/d" CMakeLists.txt || die
	}

	undetect_lib mediawiki
	undetect_lib vkontakte KVKONTAKTE

# 	undetect_lib redeyes OPENCV	#TODO: Add back when ported

	if [[ ${KDE_BUILD_TYPE} != live ]]; then
		# prepare the handbook
		mv "${WORKDIR}/${MY_P}/doc/${PN}" \
			"${WORKDIR}/${MY_P}/extra/${PN}/doc" || die
		if use handbook; then
			echo "add_subdirectory( doc )" >> CMakeLists.txt
		fi

		# prepare the translations
		mv "${WORKDIR}/${MY_P}/po" po || die
		find po -name "*.po" -and -not -name "kipiplugin*.po" -exec rm {} +
		echo "find_package(Msgfmt REQUIRED)" >> CMakeLists.txt || die
		echo "find_package(Gettext REQUIRED)" >> CMakeLists.txt || die
		echo "add_subdirectory( po )" >> CMakeLists.txt
	fi

	kde5_src_prepare
}

src_configure() {
	local mycmakeargs+=(
		$(cmake-utils_use_enable expoblending)
		$(cmake-utils_use_find_package calendar KF5CalendarCore)
		$(cmake-utils_use_find_package opengl OpenGL)
		$(cmake-utils_use_find_package panorama BISON)
		$(cmake-utils_use_find_package panorama FLEX)
	)
# 	TODO: Add back when ported
# 		$(cmake-utils_use_find_package redeyes OpenCV)
# 		$(cmake-utils_use_with crypt QCA2)
# 		$(cmake-utils_use_with videoslideshow QtGStreamer)

	kde5_src_configure
}
