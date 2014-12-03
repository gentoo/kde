# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="true"
inherit kde5

DESCRIPTION="A utility that provides information about a computer system"
HOMEPAGE="http://www.kde.org/applications/system/kinfocenter/"
KEYWORDS=""
IUSE="egl gles ieee1394 +opengl +pci samba nfs wayland X"

REQUIRED_USE="egl? ( || ( gles opengl ) )"

RDEPEND="
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep solid)
	dev-qt/qtgui:5[opengl?]
	dev-qt/qtwidgets:5
	gles? (
		dev-qt/qtgui:5[gles2]
		|| (
			media-libs/mesa[egl,gles1]
			media-libs/mesa[egl,gles2]
		)
	)
	ieee1394? ( sys-libs/libraw1394 )
	nfs? ( net-fs/nfs-utils )
	opengl? (
		virtual/glu
		virtual/opengl
	)
	pci? ( sys-apps/pciutils )
	samba? ( net-fs/samba[server(+)] )
	wayland? ( $(add_kdebase_dep kwayland) )
	X? ( x11-libs/libX11 )
	!kde-apps/kcontrol:4
	!kde-base/kcontrol:4
	!kde-base/kinfocenter:4
"
DEPEND="${RDEPEND}
	$(add_frameworks_dep plasma)
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package egl EGL)
		$(cmake-utils_use_find_package gles OpenGLES)
		$(cmake-utils_use_find_package ieee1394 RAW1394)
		$(cmake-utils_use_find_package opengl OpenGL)
		$(cmake-utils_use_find_package pci PCIUTILS)
		$(cmake-utils_use_find_package wayland KF5Wayland)
		$(cmake-utils_use_find_package X X11)
	)

	kde5_src_configure
}
