# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_DOXYGEN="true"
KDE_TEST="true"
inherit kde5

MY_PV=${PV/_/-}
MY_P=${PN}-${MY_PV}

DESCRIPTION="Digital photo management application"
HOMEPAGE="https://www.digikam.org/"
[[ ${KDE_BUILD_TYPE} = live ]] || SRC_URI="mirror://kde/stable/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="addressbook gphoto2 kipi lensfun marble semantic-desktop mysql scanner video X"

COMMON_DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep knotifyconfig)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep solid)
	$(add_kdeapps_dep libkexiv2)
	dev-libs/boost[threads]
	dev-libs/expat
	dev-qt/qtconcurrent:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
	dev-qt/qtscript:5
	dev-qt/qtsql:5[mysql]
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	>=media-gfx/exiv2-0.24:=
	media-libs/jasper
	media-libs/lcms:2
	media-libs/liblqr
	>=media-libs/libpgf-6.12.27
	media-libs/libpng:0=
	>=media-libs/opencv-3.0.0
	media-libs/tiff:0
	virtual/jpeg:0
	addressbook? (
		$(add_kdeapps_dep akonadi-contact)
		$(add_kdeapps_dep kcontacts)
	)
	scanner? ( $(add_kdeapps_dep libksane) )
	gphoto2? ( media-libs/libgphoto2:= )
	kipi? ( $(add_kdeapps_dep libkipi) )
	lensfun? ( media-libs/lensfun )
	marble? (
		$(add_frameworks_dep kbookmarks)
		$(add_frameworks_dep kitemmodels)
		$(add_kdeapps_dep marble)
	)
	semantic-desktop? ( $(add_frameworks_dep kfilemetadata) )
	mysql? ( virtual/mysql )
	video? ( dev-qt/qtmultimedia[widgets] )
	X? (
		dev-qt/qtx11extras:5
		x11-libs/libX11
	)
"
DEPEND="${COMMON_DEPEND}
	dev-cpp/eigen:3
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPEND}
	media-plugins/kipi-plugins:5
"

RESTRICT=test
# bug 366505

src_prepare() {
	undetect_lib() {
		local _use=${1}
		local _name=${2}
		[[ -z ${_name} ]] && _name=$(echo ${_use} | sed 's/./\U&/g')
		use $_use || \
			sed -i -e "/DETECT_LIB${_name}/d" CMakeLists.txt || die
	}

	undetect_lib kipi
	undetect_lib scanner KSANE

	kde5_src_prepare
}

src_configure() {
	# LQR = only allows to choose between bundled/external
	local mycmakeargs=(
		-DENABLE_OPENCV3=ON
		$(cmake-utils_use_enable addressbook AKONADICONTACTSUPPORT)
		$(cmake-utils_use_enable semantic-desktop KFILEMETADATASUPPORT)
		$(cmake-utils_use_enable mysql MYSQLSUPPORT)
		$(cmake-utils_use_enable video MEDIAPLAYER)
		$(cmake-utils_use_find_package gphoto2)
		$(cmake-utils_use_find_package lensfun LensFun)
		$(cmake-utils_use_find_package marble)
		$(cmake-utils_use_find_package X X11)
	)

	kde5_src_configure
}

src_install() {
	kde5_src_install

	if use doc; then
		# install the api documentation
		insinto /usr/share/doc/${PF}/
		doins -r ${CMAKE_BUILD_DIR}/api/html
	fi
}
