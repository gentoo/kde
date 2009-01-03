# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-workspace"
KMMODULE="plasma"
inherit kde4-meta

DESCRIPTION="Plasma: KDE desktop framework"
KEYWORDS="~amd64 ~x86"
IUSE="debug google-gadgets htmlhandbook python xcomposite xinerama"

COMMONDEPEND="!kde-base/plasma:${SLOT}
	>=kde-base/soliduiserver-${PV}:${SLOT}
	>=kde-base/kephal-${PV}:${SLOT}
	>=kde-base/ksysguard-${PV}:${SLOT}
	>=kde-base/libkworkspace-${PV}:${SLOT}
	>=kde-base/libtaskmanager-${PV}:${SLOT}
	>=kde-base/libplasmaclock-${PV}:${SLOT}
	x11-libs/libXau
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXtst
	google-gadgets? ( >=x11-misc/google-gadgets-0.10.4[qt4] )
	python? (
		>=dev-python/sip-4.7.1
		>=dev-python/PyQt4-4.4.0
		kde-base/pykde4:${SLOT}
	)
	xcomposite? ( x11-libs/libXcomposite )
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${COMMONDEPEND}
	xcomposite? ( x11-proto/compositeproto )
	xinerama? ( x11-proto/xineramaproto )"
RDEPEND="${COMMONDEPEND}
	>=kde-base/kde-menu-icons-${PV}:${SLOT}"

KMEXTRA="libs/nepomukquery/
	libs/nepomukqueryclient/"
KMEXTRACTONLY="krunner/dbus/org.freedesktop.ScreenSaver.xml
	krunner/dbus/org.kde.krunner.App.xml
	ksmserver/org.kde.KSMServerInterface.xml
	libs/kworkspace/
	libs/taskmanager/
	ksysguard/"

KMLOADLIBS="libkworkspace libplasmaclock libtaskmanager"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with google-gadgets Googlegadgets)
		$(cmake-utils_use_with python SIP)
		$(cmake-utils_use_with python PyQt4)
		$(cmake-utils_use_with python PyKDE4)
		-DWITH_Xmms=OFF"

	kde4-meta_src_configure
}
