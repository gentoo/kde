# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils kde4-base git

DESCRIPTION="Easy to use and fully integrated backup solution for KDE"
HOMEPAGE="http://flavio.castelli.name/tag/kaveau"
EGIT_REPO_URI="git://github.com/flavio/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug test"

S="${WORKDIR}/${PN}"

src_prepare() {
	if ! use test; then
		sed -i -e '/ADD_SUBDIRECTORY(tests)/d' \
			CMakeLists.txt || die "sed failed"
	fi
}

src_install() {
	kde4-base_src_install
	dodoc AUTHORS || die "dodoc failed"
}
