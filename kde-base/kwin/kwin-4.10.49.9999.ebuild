# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kde-workspace"
DECLARATIVE_REQUIRED="always"
OPENGL_REQUIRED="always"
inherit flag-o-matic kde4-meta

DESCRIPTION="KDE window manager"
KEYWORDS=""
IUSE="debug gles opengl"

COMMONDEPEND="
	$(add_kdebase_dep kactivities)
	$(add_kdebase_dep kdelibs opengl)
	$(add_kdebase_dep kephal)
	$(add_kdebase_dep libkworkspace)
	$(add_kdebase_dep liboxygenstyle)
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXfixes
	>=x11-libs/libXrandr-1.2.1
	x11-libs/libXrender
	x11-libs/libXxf86vm
	opengl? ( >=media-libs/mesa-7.10 )
	gles? (
		|| (  ( >=media-libs/mesa-7.10[egl(+),gles] <media-libs/mesa-7.12[egl(+),gles] )
			>=media-libs/mesa-7.12[egl(+),gles2] )
	)
"
DEPEND="${COMMONDEPEND}
	x11-proto/compositeproto
	x11-proto/damageproto
	x11-proto/fixesproto
	x11-proto/randrproto
	x11-proto/renderproto
"
RDEPEND="${COMMONDEPEND}
	x11-apps/scripts
"

KMEXTRACTONLY="
	ksmserver/
	libs/kephal/
	libs/oxygen/
"

# you need one of these
REQUIRED_USE="!opengl? ( gles ) !gles? ( opengl )"

src_configure() {
	# FIXME Remove when activity API moved away from libkworkspace
	append-cppflags "-I${EPREFIX}/usr/include/kworkspace"

	mycmakeargs=(
		$(cmake-utils_use_with gles OpenGLES)
		$(cmake-utils_use gles KWIN_BUILD_WITH_OPENGLES)
		$(cmake-utils_use_with opengl OpenGL)
		-DWITH_X11_Xcomposite=ON
	)

	kde4-meta_src_configure
}
