# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME=kdebase-workspace
KMMODULE=plasma
inherit kde4-meta

DESCRIPTION="Plasma: KDE desktop framework"
KEYWORDS="~amd64 ~x86"
IUSE="debug google-gadgets htmlhandbook xcomposite xinerama"

COMMONDEPEND="!kde-base/plasma:${SLOT}
	>=kde-base/soliduiserver-${PV}:${SLOT}
	>=app-misc/strigi-0.6
	>=kde-base/libkworkspace-${PV}:${SLOT}
	>=kde-base/libtaskmanager-${PV}:${SLOT}
	>=kde-base/libplasma-${PV}:${SLOT}
	>=kde-base/libplasmaclock-${PV}:${SLOT}
	x11-libs/libXau
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXtst
	google-gadgets? ( >=x11-misc/google-gadgets-0.10.2 )
	xcomposite? ( x11-libs/libXcomposite )
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${COMMONDEPEND}
	xcomposite? ( x11-proto/compositeproto )
	xinerama? ( x11-proto/xineramaproto )"
RDEPEND="${COMMONDEPEND}
	>=kde-base/kde-menu-icons-${PV}:${SLOT}"
PDEPEND=">=kde-base/dolphin-${PV}:${SLOT}
	kde-base/kdeartwork-iconthemes:${SLOT}"

KMEXTRACTONLY="	krunner/org.freedesktop.ScreenSaver.xml
				krunner/org.kde.krunner.Interface.xml
				krunner/org.kde.krunner.App.xml
				ksmserver/org.kde.KSMServerInterface.xml"

KMLOADLIBS="libplasma"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with xcomposite X11_Xcomposite)
		$(cmake-utils_use_with xinerama X11_Xinerama)"

	kde4-meta_src_configure
}
