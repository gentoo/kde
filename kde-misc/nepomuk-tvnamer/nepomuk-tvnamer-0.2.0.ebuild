# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit kde4-base

MY_PN="148910-nepomuktvnamer-0.2.0.tar.bz2"
MY_P="nepomuk-tvnamer-0.2.0"
DESCRIPTION="A command line tool which will lookup TV Show information on thetvdb.com and store 
it in Nepomuk"
HOMEPAGE="http://kde-apps.org/content/show.php/Nepomuk+TVNamer?content=148910"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/${MY_PN} -> ${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/shared-desktop-ontologies
	media-libs/libtvdb"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	mkdir ${S} && cd ${S} || die
	kde4-base_src_unpack
	mv nepomuktvnamer-0.2.0/* . 
}

