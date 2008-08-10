# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdebase-workspace
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="KDE window manager"
KEYWORDS="~amd64"
IUSE="captury debug opengl xcomposite xinerama"

COMMONDEPEND="
	x11-libs/libXdamage
	x11-libs/libXfixes
	>=x11-libs/libXrandr-1.2.1
	x11-libs/libXrender
	captury? ( media-libs/libcaptury )
	opengl? ( virtual/opengl )
	xcomposite? ( x11-libs/libXcomposite )
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${COMMONDEPEND}
	x11-proto/damageproto
	x11-proto/renderproto
	xcomposite? ( x11-proto/compositeproto )
	xinerama? ( x11-proto/xineramaproto )"
RDEPEND="${COMMONDEPEND}"

src_compile() {
	if ! use captury; then
		sed -e 's:^PKGCONFIG..libcaptury:#DONOTFIND &:' \
			-i "${S}"/kwin/effects/CMakeLists.txt || \
			die "Making captury optional failed."
	fi

	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with xcomposite X11_Xcomposite)
		$(cmake-utils_use_with xinerama X11_Xinerama)"

	kde4-meta_src_compile
}
