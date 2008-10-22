# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME=kdebase-workspace
KMMODULE=plasma
inherit kde4svn-meta

DESCRIPTION="Plasma: KDE desktop framework"
KEYWORDS=""
IUSE="debug google-gadgets htmlhandbook python xcomposite xinerama"

COMMONDEPEND="!kde-base/plasma:${SLOT}
	>=kde-base/soliduiserver-${PV}:${SLOT}
	>=app-misc/strigi-0.5.9
	>=kde-base/libkworkspace-${PV}:${SLOT}
	>=kde-base/libtaskmanager-${PV}:${SLOT}
	>=kde-base/libplasma-${PV}:${SLOT}
	>=kde-base/libplasmaclock-${PV}:${SLOT}
	x11-libs/libXau
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXtst
	google-gadgets? ( >=x11-misc/google-gadgets-0.10.3[qt] )
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
PDEPEND="kde-base/kdeartwork-iconthemes:${SLOT}"

KMEXTRACTONLY="krunner/org.freedesktop.ScreenSaver.xml
	krunner/org.kde.krunner.App.xml
	ksmserver/org.kde.KSMServerInterface.xml
	libs/kworkspace/
	libs/taskmanager/
	libs/plasma/"

KMLOADLIBS="libkworkspace libplasma libplasmaclock"

src_compile() {
	# Remove this if a patch has been applied upstream.
	#sed -i -e 's/plasmapkg plasma/plasmapkg ${KDE4_KIO_LIBS} plasma/'\
	#	"${S}"/plasma/tools/plasmapkg/CMakeLists.txt || die "sed failed."
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with google-gadgets Googlegadgets)
		$(cmake-utils_use_with python SIP)
		$(cmake-utils_use_with python PyQt4)
		$(cmake-utils_use_with python PyKDE4)
		$(cmake-utils_use_with xcomposite X11_Xcomposite)
		$(cmake-utils_use_with xinerama X11_Xinerama)"

	kde4overlay-meta_src_compile
}
