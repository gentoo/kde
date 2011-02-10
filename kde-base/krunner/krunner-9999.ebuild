# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

KMNAME="kdebase-workspace"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="KDE Command Runner"
IUSE="debug"
KEYWORDS=""

COMMONDEPEND="
	$(add_kdebase_dep kcheckpass)
	$(add_kdebase_dep kephal)
	$(add_kdebase_dep ksmserver)
	$(add_kdebase_dep ksysguard)
	$(add_kdebase_dep libkworkspace)
	$(add_kdebase_dep libplasmagenericshell)
	!aqua? (
		x11-libs/libXxf86misc
		x11-libs/libXcursor
		x11-libs/libXScrnSaver
	)
"
DEPEND="${COMMONDEPEND}
	!aqua? (
		x11-libs/libXcursor
		x11-proto/xf86miscproto
		x11-proto/scrnsaverproto
	)
"
RDEPEND="${COMMONDEPEND}"

KMEXTRACTONLY="
	libs/kdm/
	libs/kephal/
	libs/ksysguard/
	libs/kworkspace/
	libs/plasmagenericshell/
	kcheckpass/
	ksmserver/org.kde.KSMServerInterface.xml
	ksysguard/
	plasma/screensaver/shell/org.kde.plasma-overlay.App.xml
"

KMLOADLIBS="libkworkspace"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with opengl OpenGL)
	)

	kde4-meta_src_configure
}
