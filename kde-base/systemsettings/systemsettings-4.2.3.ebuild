# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/systemsettings/systemsettings-4.2.2.ebuild,v 1.3 2009/04/17 06:48:47 alexxy Exp $

EAPI="2"

KMNAME="kdebase-workspace"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="System settings utility"
IUSE="debug doc +usb xinerama"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"

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
	xinerama? ( x11-libs/libXinerama )
"
DEPEND="${COMMONDEPEND}
	x11-proto/kbproto
	x11-proto/xextproto
	xinerama? ( x11-proto/xineramaproto )
"
RDEPEND="${COMMONDEPEND}
	>=kde-base/kcontrol-${PV}:${SLOT}[kdeprefix=]
	x11-apps/setxkbmap
	|| (
		x11-misc/xkbdata
		x11-misc/xkeyboard-config
	)
"

KMEXTRA="
	kcontrol/
"
KMEXTRACTONLY="
	krunner/dbus/org.kde.krunner.App.xml
	krunner/dbus/org.kde.screensaver.xml
	kwin/
	libs/
	plasma/
"

PATCHES=( "$FILESDIR/20_use_dejavu_as_default_font.patch" )

src_unpack() {
	if use doc; then
		KMEXTRA="${KMEXTRA}
			doc/kcontrol
		"
	fi

	kde4-meta_src_unpack
}

src_prepare() {
	sed -i -e 's/systemsettingsrc DESTINATION ${SYSCONF_INSTALL_DIR}/systemsettingsrc DESTINATION ${CONFIG_INSTALL_DIR}/' \
		systemsettings/CMakeLists.txt \
		|| die "Failed to fix systemsettingsrc install location"

	if ! version_is_at_least 4.1.2 "$(gcc-fullversion)" ; then
		ewarn
		ewarn "The kxkb module will be built without keyboard hot-plugging"
		ewarn "support.  GCC version 4.1.2 or greater is required to build"
		ewarn "kxkb's keyboard hot-plugging code."
		ewarn
		ebeep 5
		epatch "$FILESDIR/${PN}-4.2.1-kxkb-strip-hot_plugging-support.patch"
	fi

	kde4-meta_src_prepare
}

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
