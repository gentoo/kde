# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-workspace"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="KDE Command Runner"
IUSE="debug"
KEYWORDS=""

COMMONDEPEND="
	$(add_kdebase_dep kephal)
	$(add_kdebase_dep ksmserver)
	$(add_kdebase_dep ksysguard)
	$(add_kdebase_dep libkworkspace)
	x11-libs/libXxf86misc
	x11-libs/libXcursor
	x11-libs/libXScrnSaver
"
DEPEND="${COMMONDEPEND}
	x11-libs/libXcursor
	x11-proto/xf86miscproto
	x11-proto/scrnsaverproto
"
RDEPEND="${COMMONDEPEND}"

KMEXTRACTONLY="
	libs/kdm/
	libs/ksysguard/
	libs/kworkspace/
	kcontrol/
	ksysguard/
	ksmserver/org.kde.KSMServerInterface.xml
	plasma/screensaver/shell/org.kde.plasma-overlay.App.xml
	kcheckpass/
"

KMLOADLIBS="libkworkspace"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with opengl OpenGL)"

	kde4-meta_src_configure
}
