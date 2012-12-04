# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
KDE_LINGUAS="de es fr it nb no pl"

inherit kde4-base

DESCRIPTION="Kover is an easy to use WYSIWYG CD cover printer with CDDB support"
HOMEPAGE="http://lisas.de/kover/"
SRC_URI="http://lisas.de/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	sys-devel/gettext
"
RDEPEND="
	dev-libs/libcdio
	media-libs/libcddb
"
PATCHES=(
	"${FILESDIR}/${PN}-4-cflags.patch"
)
