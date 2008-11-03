# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

NEED_KDE=":4.1"

inherit kde4-base

DESCRIPTION="A KDE4 Plasma weatherforecast applet"
HOMEPAGE="http://kde-look.org/content/show.php/weatherforecast?content=92149"
SRC_URI="http://sauron.savel.pp.ru/dist-files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="!kde-misc/plasmoids
		kde-base/libplasma"

S="${WORKDIR}/weatherforecast"

pkg_postinst()
{
	elog "Looking for wheather ZIP code:"
	elog "1. Go to http://weather.yahoo.com/"
	elog "2. Type in your city, country and click Go"
	elog "3. Copy the 8 character location ID from the URL on the next page (ie for Hong Kong, China it is CHXX0049)"
	elog "4. Paste the location ID into the widgets zip code field"
}
