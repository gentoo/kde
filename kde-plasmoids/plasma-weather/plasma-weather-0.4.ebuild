# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

NEED_KDE=":4.1"
inherit kde4-base

DESCRIPTION="A KDE4 Plasma weather applet"
HOMEPAGE="http://www.kde-look.org/content/show.php/Weather+Plasmoid?content=84251"
KEYWORDS="~amd64 ~x86"
SRC_URI="http://download83.mediafire.com/ms6xljhh1frg/zsj2dxxj2sl/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="4.1"
IUSE=""

DEPEND="!kde-misc/plasmoids
		kde-base/libplasma"

S="${WORKDIR}/weather"

pkg_postinst()
{
	einfo "Looking for wheather ZIP code:"
	einfo "1. Go to http://weather.yahoo.com/"
	einfo "2. Type in your city, country and click Go"
	einfo "3. Copy the 8 character location ID from the URL on the next page (ie for Hong Kong, China it is CHXX0049)"
	einfo "4. Paste the location ID into the widgets zip code field"
}

