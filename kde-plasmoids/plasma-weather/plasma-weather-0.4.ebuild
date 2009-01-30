# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="A KDE4 Plasma weather applet"
HOMEPAGE="http://www.kde-look.org/content/show.php/Weather+Plasmoid?content=84251"
SRC_URI="
	http://omploader.org/vdWxn/${P}.tar.gz
	http://download83.mediafire.com/jxlmcdsokmcg/zsj2dxxj2sl//${P}.tar.gz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

S="${WORKDIR}/weather"

pkg_postinst() {
	elog "Looking for wheather ZIP code:"
	elog "1. Go to http://weather.yahoo.com/"
	elog "2. Type in your city, country and click Go"
	elog "3. Copy the 8 character location ID from the URL on the next page (ie for Hong Kong, China it is CHXX0049)"
	elog "4. Paste the location ID into the widgets zip code field"

	kde4-base_pkg_postinst
}
