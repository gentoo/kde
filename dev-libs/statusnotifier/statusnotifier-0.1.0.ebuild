# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools

DESCRIPTION="Library to use KDE's StatusNotifierItem via GObject"
HOMEPAGE="https://github.com/jjk-jacky/statusnotifier"
SRC_URI="https://github.com/jjk-jacky/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/glib:2
	x11-libs/gdk-pixbuf"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}
