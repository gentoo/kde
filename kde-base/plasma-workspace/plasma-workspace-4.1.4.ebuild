# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/plasma-workspace/plasma-workspace-4.1.3.ebuild,v 1.2 2008/11/16 08:26:06 vapier Exp $

EAPI="2"

KMNAME=kdebase-workspace
KMMODULE=plasma
inherit kde4-meta

DESCRIPTION="Plasma: KDE desktop framework"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook xcomposite xinerama"

COMMONDEPEND="!kde-base/plasma:${SLOT}
	>=kde-base/soliduiserver-${PV}:${SLOT}
	>=app-misc/strigi-0.5.9
	>=kde-base/libkworkspace-${PV}:${SLOT}
	>=kde-base/libtaskmanager-${PV}:${SLOT}
	>=kde-base/libplasma-${PV}:${SLOT}
	x11-libs/libXau
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXtst
	xcomposite? ( x11-libs/libXcomposite )
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${COMMONDEPEND}
	xcomposite? ( x11-proto/compositeproto )
	xinerama? ( x11-proto/xineramaproto )"
RDEPEND="${COMMONDEPEND}
	>=kde-base/kde-menu-icons-${PV}:${SLOT}"
PDEPEND=">=kde-base/dolphin-${PV}:${SLOT}
	kde-base/kdeartwork-iconthemes:${SLOT}"

KMEXTRACTONLY="krunner/org.freedesktop.ScreenSaver.xml
	krunner/org.kde.krunner.Interface.xml
	ksmserver/org.kde.KSMServerInterface.xml
	libs/taskmanager/
	libs/plasma/"

KMLOADLIBS="libplasma"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with xcomposite X11_Xcomposite)
		$(cmake-utils_use_with xinerama X11_Xinerama)"

	kde4-meta_src_configure
}
