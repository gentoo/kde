# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="A collection of PHP utility classes"
HOMEPAGE="https://github.com/phacility/libphutil"
EGIT_REPO_URI=( "https://github.com/phacility/${PN}.git" )

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-lang/php"

src_install() {
	dodir /opt/${PN}
	cp -a "${S}"/* "${D}/opt/${PN}" || die
}
