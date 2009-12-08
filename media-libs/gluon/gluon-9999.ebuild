# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

OPENGL_REQUIRED="always"
inherit git kde4-base

DESCRIPTION=""
HOMEPAGE="http://gluon.tuxfamily.org/"
SRC_URI=""
EGIT_REPO_URI="git://gitorious.org/gluon/gluon.git"

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

PATCHES=(
	"${FILESDIR}/${PN}-pic-fix.patch"
)

src_unpack() {
	git_src_unpack
}

src_prepare() {
	kde4-base_src_prepare

	sed -i '/add_subdirectory(src)/s/^#//' "${S}"/CMakeLists.txt || die "couldn't re-enable main library"
}
