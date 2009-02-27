# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwin/kwin-4.2.0.ebuild,v 1.2 2009/02/01 08:15:31 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdebase-workspace"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="KDE window manager"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug captury xcomposite xinerama"

COMMONDEPEND="x11-libs/libXdamage
	x11-libs/libXfixes
	>=x11-libs/libXrandr-1.2.1
	x11-libs/libXrender
	captury? ( media-libs/libcaptury )
	opengl? ( virtual/opengl )
	xcomposite? ( x11-libs/libXcomposite )
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${COMMONDEPEND}
	kde-base/kephal:${SLOT}
	x11-proto/damageproto
	x11-proto/renderproto
	xcomposite? ( x11-proto/compositeproto )
	xinerama? ( x11-proto/xineramaproto )"
RDEPEND="${COMMONDEPEND}"

src_configure() {
	if ! use captury; then
		sed -e 's:^PKGCONFIG..libcaptury:#DONOTFIND &:' \
			-i "${S}"/kwin/effects/CMakeLists.txt || \
			die "Making captury optional failed."
	fi

	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with opengl OpenGL)"

	kde4-meta_src_configure
}
