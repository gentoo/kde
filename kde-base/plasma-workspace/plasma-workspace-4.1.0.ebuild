# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2_pre1"

KMNAME=kdebase-workspace
KMMODULE=plasma
inherit kde4-meta

DESCRIPTION="Plasma: KDE desktop framework"
KEYWORDS="~amd64"
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
PDEPEND="kde-base/kdeartwork-iconthemes:${SLOT}"

KMEXTRACTONLY="krunner/org.freedesktop.ScreenSaver.xml
	krunner/org.kde.krunner.Interface.xml
	ksmserver/org.kde.KSMServerInterface.xml
	libs/taskmanager/
	libs/plasma/"

KMLOADLIBS="libplasma"

# check disable for strigi-9999
#pkg_setup() {
#	if ! built_with_use app-misc/strigi dbus && ! built_with_use app-misc/strigi qt4 ; then
#		eerror "Need app-misc/strigi with dbus and qt4 enabled"
#		die "Need app-misc/strigi with dbus and qt4 enabled"
#	fi
#}

src_compile() {
	# Remove this if a patch has been applied upstream.
	#sed -i -e 's/plasmapkg plasma/plasmapkg ${KDE4_KIO_LIBS} plasma/'\
	#	"${S}"/plasma/tools/plasmapkg/CMakeLists.txt || die "sed failed."
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with xcomposite X11_Xcomposite)
		$(cmake-utils_use_with xinerama X11_Xinerama)"

	kde4-meta_src_compile
}
