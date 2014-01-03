# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby18"
inherit kde4-base ruby-ng

DESCRIPTION="Board game suite for KDE"
HOMEPAGE="http://pcapriotti.github.com/kaya/"
EGIT_REPO_URI="git://github.com/pcapriotti/kaya.git"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS=""
IUSE="debug"

DEPEND=""
RDEPEND=""
ruby_add_rdepend "kde-base/korundum"
ruby_add_rdepend "dev-ruby/builder"

EGIT_SOURCE_UNPACK="${WORKDIR}/all/${P}"

pkg_setup() {
	ruby-ng_pkg_setup
	kde4-base_pkg_setup
}

all_ruby_unpack() {
	kde4-base_src_unpack
}

all_ruby_prepare() {
	kde4-base_src_prepare
}

each_ruby_configure() {
	CMAKE_USE_DIR=${S}
	mycmakeargs=(
		-DRUBY_LIBRARY=$(ruby_get_libruby)
		-DRUBY_INCLUDE_PATH=$(ruby_get_hdrdir)
		-DRUBY_EXECUTABLE=${RUBY}
	)
	kde4-base_src_configure
}

each_ruby_compile() {
	CMAKE_USE_DIR=${S}
	kde4-base_src_compile
}

each_ruby_install() {
	CMAKE_USE_DIR=${S}
	kde4-base_src_install
}

pkg_postinst() {
	elog "To be able to use the kaya board game front-end, you need to install at least one"
	elog "of the following game engines: "
	elog "    games-board/gnuchess"
	elog "    games-board/gnushogi"
}
