# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/krunner/krunner-4.2.1.ebuild,v 1.2 2009/03/08 13:57:46 scarabeus Exp $

EAPI="2"

KMNAME="kdebase-workspace"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="KDE Command Runner"
IUSE="debug xcomposite xscreensaver"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

COMMONDEPEND="
	>=kde-base/ksmserver-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/ksysguard-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libkworkspace-${PV}:${SLOT}[kdeprefix=]
	x11-libs/libXxf86misc
	opengl? ( virtual/opengl )
	xcomposite? ( x11-libs/libXcomposite )
	xscreensaver? ( x11-libs/libXScrnSaver )
"
DEPEND="${COMMONDEPEND}
	x11-proto/xf86miscproto
	xcomposite? ( x11-proto/compositeproto )
	xscreensaver? ( x11-proto/scrnsaverproto )
"
RDEPEND="${COMMONDEPEND}"

KMEXTRACTONLY="
	libs/kdm/
	libs/ksysguard/
	libs/kworkspace/
	kcontrol/
	ksysguard/
	ksmserver/org.kde.KSMServerInterface.xml
	plasma/shells/screensaver/org.kde.plasma-overlay.App.xml
	kcheckpass/
"

KMLOADLIBS="libkworkspace"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with opengl OpenGL)"

	kde4-meta_src_configure
}
