# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwin/kwin-4.6.3.ebuild,v 1.2 2011/05/09 10:05:21 scarabeus Exp $

EAPI=4

KMNAME="kdebase-workspace"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="KDE window manager"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug xcomposite xinerama"

# NOTE disabled for now: captury? ( media-libs/libcaptury )
COMMONDEPEND="
	$(add_kdebase_dep kephal)
	$(add_kdebase_dep libkworkspace)
	$(add_kdebase_dep liboxygenstyle)
	x11-libs/libXdamage
	x11-libs/libXfixes
	>=x11-libs/libXrandr-1.2.1
	x11-libs/libXrender
	opengl? ( virtual/opengl )
	xcomposite? ( x11-libs/libXcomposite )
	xinerama? ( x11-libs/libXinerama )
"
DEPEND="${COMMONDEPEND}
	x11-proto/damageproto
	x11-proto/fixesproto
	x11-proto/randrproto
	x11-proto/renderproto
	xcomposite? ( x11-proto/compositeproto )
	xinerama? ( x11-proto/xineramaproto )
"
RDEPEND="${COMMONDEPEND}
	x11-apps/scripts
"

KMEXTRACTONLY="
	ksmserver/
	libs/kephal/
	libs/oxygen/
"

PATCHES=(
	"${FILESDIR}/${PN}-4.4.2-xinerama_cmake_automagic.patch"
	"${FILESDIR}/${PN}-fix-opengl.patch"
)

src_prepare() {
# NOTE uncomment when enabled again by upstream
#	if ! use captury; then
#		sed -e 's:^PKGCONFIG..libcaptury:#DONOTFIND &:' \
#			-i kwin/effects/CMakeLists.txt || \
#			die "Making captury optional failed."
#	fi

	kde4-meta_src_prepare
}

src_configure() {
	# FIXME Remove when activity API moved away from libkworkspace
	append-cppflags "-I${EKDEDIR}/include/kworkspace"

	mycmakeargs=(
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with xinerama X11_Xinerama)
	)

	kde4-meta_src_configure
}
