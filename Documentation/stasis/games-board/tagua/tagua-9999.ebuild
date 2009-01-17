# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

NEED_KDE="svn"

EGIT_REPO_URI="git://repo.or.cz/tagua.git"
CPPUNIT_REQUIRED="optional"
inherit kde4overlay-base git

# Install to KDEDIR rather than /usr, to slot properly.
PREFIX="${KDEDIR}"

DESCRIPTION="Tagua is a generic board game application for KDE."
HOMEPAGE="http://www.tagua-project.org/"

LICENSE="GPL-2"
SLOT="kde-svn"
KEYWORDS=""
IUSE="debug mmx sse2"

DEPEND="
	>=dev-lang/lua-5.1.1
	>=dev-libs/boost-1.34
	kde-base/libkdegames:${SLOT}
	kde-base/qimageblitz"
RDEPEND="${DEPEND}"

src_unpack() {
	git_src_unpack

	if ! use test; then
		sed -e "/find_package(CPPUNIT)/s/^/#DONOTFIND /" \
		-i "${S}"/tests/CMakeLists.txt || die "Sed to disable tests failed."
	fi
}

src_compile() {
	mycmakeargs="${mycmakeargs} -DSYSTEM_LUA=1"
	if ! use mmx; then
		mycmakeargs="${mycmakeargs} -DCOMPILER_HAVE_X86_MMX=0"
	fi
	if ! use sse2; then
		mycmakeargs="${mycmakeargs} -DCOMPILER_HAVE_X86_SSE2=0"
	fi

	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install

	dodoc AUTHORS CHANGELOG README RELEASE || die "installing docs failed"
}
