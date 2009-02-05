# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KMNAME="extragear/pim"
inherit kde4-base

DESCRIPTION="A Qt/KDE based mail client based on Akonadi."
HOMEPAGE="http://www.kde-apps.org/content/show.php/Mailody?content=47793"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="live"
IUSE="debug kontact"

DEPEND="
	>=kde-base/marble-${KDE_MINIMAL}[kdeprefix=]
	kontact? ( >=kde-base/kontactinterfaces-${KDE_MINIMAL}[kdeprefix=] )
"
RDEPEND="${DEPEND}
	>=kde-base/nepomuk-${KDE_MINIMAL}[kdeprefix=]
"

src_configure() {
	sed -i -e 's/ADD_SUBDIRECTORY( kontact )/#DONOTCOMPILE ADD_SUBDIRECTORY( kontact )/g' \
		CMakeLists.txt || die "sed failed"

	kde4-base_src_configure
}
