# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

MY_P="plasma-weatherforecast-${PV}-kde-4.2"

DESCRIPTION="KDE4 plasmoid. Weather forecast."
HOMEPAGE="http://kde-look.org/content/show.php/weatherforecast?content=92149"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/92149-${MY_P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep plasma-workspace)
"
RDEPEND="${DEPEND}
	!kde-plasmoids/plasma-weatherforecast
"

S="${WORKDIR}/${MY_P}"

pkg_postinst() {
	kde4-base_pkg_postinst

	echo
	elog "Looking for weather ZIP code:"
	elog "1. Go to http://weather.yahoo.com/"
	elog "2. Type in your city, country and click Go"
	elog "3. Copy the 8 character location ID from the URL"
	elog "   on the next page (ie for Hong Kong, China it is CHXX0049)"
	elog "4. Paste the location ID into the widgets zip code field"
	echo
}
