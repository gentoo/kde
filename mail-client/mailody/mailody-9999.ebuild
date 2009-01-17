# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
IUSE=""
SLOT="live"
KMNAME="extragear/pim"
inherit kde4-base

DESCRIPTION="A Qt/KDE based mail client based on Akonadi."
HOMEPAGE="http://www.kde-apps.org/content/show.php/Mailody?content=47793"

LICENSE="GPL-2"
IUSE="${IUSE} kontact"

DEPEND="kde-base/kdelibs:${SLOT}
	kde-base/kdepimlibs:${SLOT}
	kde-base/marble:${SLOT}
	kde-base/nepomuk:${SLOT}
	kontact? ( kde-base/kontactinterfaces:${SLOT} )"

src_configure() {
	sed -e 's/ADD_SUBDIRECTORY( kontact )/#DONOTCOMPILE ADD_SUBDIRECTORY( kontact )/g' -i "${WORKDIR}/${P}/CMakeLists.txt"
	kde4-base_src_configure
}
