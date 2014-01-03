# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt4-r2
DESCRIPTION="Configuration for the mobile Plasma shell"
HOMEPAGE="http://www.kde.org/"
SRC_URI="mirror://kde/stable/active/4.0/src/${P}.tar.xz"

LICENSE="BSD"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="hunspell presage"

DEPEND="
	hunspell? ( app-text/hunspell )
	presage? ( app-text/presage )
	x11-misc/maliit-framework
"
RDEPEND="${DEPEND}"

src_configure() {
	local myconf="nostrip"
	use hunspell && myconf="${myconf} enable-hunspell"
	use presage && myconf="${myconf} enable-presage"
	qmake PREFIX="${EPREFIX}/usr" CONFIG+="${myconf}"
}
