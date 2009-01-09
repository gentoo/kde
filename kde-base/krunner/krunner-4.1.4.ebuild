# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/krunner/krunner-4.1.3.ebuild,v 1.2 2008/11/16 07:59:43 vapier Exp $

EAPI="2"

KMNAME=kdebase-workspace
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="KDE Command Runner"
IUSE="debug opengl xcomposite xscreensaver"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

COMMONDEPEND="
	>=kde-base/ksmserver-${PV}:${SLOT}
	>=kde-base/ksysguard-${PV}:${SLOT}
	>=kde-base/libkworkspace-${PV}:${SLOT}
	>=kde-base/libplasma-${PV}:${SLOT}
	x11-libs/libXxf86misc
	opengl? ( virtual/opengl )
	xcomposite? ( x11-libs/libXcomposite )
	xscreensaver? ( x11-libs/libXScrnSaver )"
DEPEND="${COMMONDEPEND}
	x11-proto/xf86miscproto
	xcomposite? ( x11-proto/compositeproto )"
RDEPEND="${COMMONDEPEND}
	>=kde-base/kdebase-data-${PV}:${SLOT}"

KMEXTRACTONLY="
	libs/kdm/
	libs/ksysguard/
	libs/kworkspace/
	kcontrol/
	ksysguard/
	ksmserver/org.kde.KSMServerInterface.xml
	kcheckpass/"

KMLOADLIBS="libkworkspace libplasma"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with xcomposite X11_Xcomposite)
		$(cmake-utils_use_with xscreensaver X11_Xscreensaver)"

	kde4-meta_src_configure
}
