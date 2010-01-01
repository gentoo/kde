# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils git kde4-base

DESCRIPTION="Easy to use and fully integrated backup solution for KDE"
HOMEPAGE="http://flavio.castelli.name/tag/kaveau"
EGIT_REPO_URI="git://github.com/flavio/${PN}.git"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug test"

RDEPEND="
	!app-backup/kaveau:0
"

S="${WORKDIR}/${PN}"

src_unpack() {
	git_src_unpack
}

src_prepare() {
	kde4-base_src_prepare

	if ! use test; then
		sed -i -e '/ADD_SUBDIRECTORY(tests)/d' \
			CMakeLists.txt || die "sed failed"
	fi
}
