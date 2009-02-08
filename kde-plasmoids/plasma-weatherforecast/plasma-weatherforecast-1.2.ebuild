# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_MINIMAL="4.2"
inherit kde4-base

MY_P="${P}-kde-4.2"

DESCRIPTION="A KDE4 Plasma weatherforecast applet"
HOMEPAGE="http://kde-look.org/content/show.php/weatherforecast?content=92149"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/92149-${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

S="${WORKDIR}/${MY_P}"

pkg_postinst() {
	elog "Looking for wheather ZIP code:"
	elog "1. Go to http://weather.yahoo.com/"
	elog "2. Type in your city, country and click Go"
	elog "3. Copy the 8 character location ID from the URL on the next page (ie for Hong Kong, China it is CHXX0049)"
	elog "4. Paste the location ID into the widgets zip code field"

	kde4-base_pkg_postinst
}
