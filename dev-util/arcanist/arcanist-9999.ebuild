# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3

DESCRIPTION="Command line interface for Phabricator"
HOMEPAGE="https://github.com/phacility/arcanist"
EGIT_REPO_URI=( "https://github.com/phacility/${PN}.git" )

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-lang/php
	dev-libs/libphutil
"

src_install() {
	dodir /opt/${PN}
	cp -a "${S}"/* "${D}/opt/${PN}"
	dosym /opt/${PN}/bin/arc /usr/bin/arc
}
