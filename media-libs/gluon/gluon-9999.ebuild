# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

OPENGL_REQUIRED="always"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="Free and Open Source framework for creating and distributing games"
HOMEPAGE="http://gluon.tuxfamily.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
IUSE=""

COMMON_DEPEND="
	media-libs/glew
	media-libs/libogg
	media-libs/libsndfile
	media-libs/libvorbis
	media-libs/openal
	virtual/glu
	virtual/opengl
	x11-libs/libXrandr
"
DEPEND="${COMMON_DEPEND}
	dev-cpp/eigen:2
	x11-proto/randrproto
"
RDEPEND="${COMMON_DEPEND}"

src_prepare() {
	kde4-base_src_prepare

	sed -i '/add_subdirectory(src)/s/^#//' "${S}"/CMakeLists.txt || die "couldn't re-enable main library"
}
