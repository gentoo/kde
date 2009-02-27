# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/systemsettings/systemsettings-4.2.0-r1.ebuild,v 1.1 2009/02/17 19:32:06 scarabeus Exp $

EAPI="2"

KMNAME="kdebase-workspace"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="System settings utility"
IUSE="debug htmlhandbook +usb xinerama"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

COMMONDEPEND="
	>=dev-libs/glib-2
	media-libs/fontconfig
	>=media-libs/freetype-2
	>=x11-libs/libxklavier-3.2
	x11-libs/libXcursor
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXft
	x11-libs/libXrandr
	x11-libs/libXtst
	opengl? ( virtual/opengl )
	usb? ( dev-libs/libusb )
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${COMMONDEPEND}
	x11-proto/xextproto
	x11-proto/kbproto
	xinerama? ( x11-proto/xineramaproto )"
RDEPEND="${COMMONDEPEND}
	>=kde-base/kcontrol-${PV}:${SLOT}
	|| ( x11-misc/xkeyboard-config
		x11-misc/xkbdata )
	x11-apps/setxkbmap"

KMEXTRA="kcontrol/"

KMEXTRACTONLY="krunner/dbus/org.kde.krunner.App.xml
		krunner/dbus/org.kde.screensaver.xml
		kwin/
		libs/
		plasma/"

PATCHES=( "$FILESDIR/20_use_dejavu_as_default_font.patch" )

# FIXME: is have_openglxvisual found without screensaver
src_configure() {
	# Old keyboard-detection code is unmaintained,
	# so we force the new stuff, using libxklavier.
	mycmakeargs="${mycmakeargs}
		-DUSE_XKLAVIER=ON -DWITH_LibXKlavier=ON
		-DWITH_GLIB2=ON -DWITH_GObject=ON
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with usb USB)
		$(cmake-utils_use_with xinerama X11_Xinerama)"

	kde4-meta_src_configure
}
