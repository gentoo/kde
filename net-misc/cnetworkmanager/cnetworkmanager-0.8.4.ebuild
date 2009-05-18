# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=0

inherit base

DESCRIPTION="Command line interface for NetworkManager."
HOMEPAGE="http://vidner.net/martin/software/cnetworkmanager/"
SRC_URI="http://vidner.net/martin/software/cnetworkmanager/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.5
	>=dev-python/dbus-python-0.80.2
	>=dev-python/pygobject-2.14.0
	>=net-misc/networkmanager-0.7.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	sed -i \
		-e "s:/local::g" \
		Makefile || die "sed failed"
	cd "${S}"
}
