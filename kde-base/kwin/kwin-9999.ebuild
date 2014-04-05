# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="true"
KDE_TEST="true"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="KDE window manager"
LICENSE="GPL-2+"
KEYWORDS=""
IUSE="gles2 +opengl wayland"

REQUIRED_USE="^^ ( gles2 opengl )"

COMMON_DEPEND="
	$(add_frameworks_dep kactivities)
	$(add_frameworks_dep kauth)
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep kdeclarative)
	$(add_frameworks_dep kglobalaccel)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kinit)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knewstuff)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep plasma)
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5[gles2=,opengl=]
	dev-qt/qtmultimedia:5
	dev-qt/qtscript:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcursor
	x11-libs/libXext
	x11-libs/libXxf86vm
	x11-libs/xcb-util-image
	x11-libs/xcb-util-keysyms
	wayland? (
		>=dev-libs/wayland-1.2
		x11-libs/libxkbcommon
	)
"
RDEPEND="${COMMON_DEPEND}
	!kde-base/kwin:4
	!kde-base/systemsettings:4
"
DEPEND="${COMMON_DEPEND}
	dev-qt/designer:5
	dev-qt/qtconcurrent:5
	x11-proto/xproto
	gles2? ( media-libs/mesa[egl,gles2] )
	opengl? ( media-libs/mesa[egl] )
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package wayland)
	)

	kde5_src_configure
}
