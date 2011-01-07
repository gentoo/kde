# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/choqok/choqok-0.9.90-r1.ebuild,v 1.1 2010/09/07 01:22:48 tampakrap Exp $

EAPI=3

KMNAME="extragear/network"

inherit git kde4-base

DESCRIPTION="A Free/Open Source micro-blogging client for KDE"
HOMEPAGE="http://choqok.gnufolks.org/"
EGIT_REPO_URI="git://anongit.kde.org/choqok"

LICENSE="GPL-3"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="dev-libs/qjson
		>=dev-libs/qoauth-1.0.1"
RDEPEND="${DEPEND}"

src_unpack() {
	git_src_unpack
}
