# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit kde4-base

MY_PN="149182-google_contacts_plasmoid.tar.gz"
MY_P="google-contacts-plasmoid"
DESCRIPTION="Plasmoid for Google contacts stored on akonadi"
HOMEPAGE="http://kde-apps.org/content/show.php/Google+contacts?content=149182"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/${MY_PN} -> ${MY_P}.tar.gz"

LICENSE="GPL-2"

SLOT="4"
KEYWORDS=""
IUSE=""

DEPEND="kde-misc/akonadi-google"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	mkdir "${S}" && cd "${S}" || die
	kde4-base_src_unpack
}
