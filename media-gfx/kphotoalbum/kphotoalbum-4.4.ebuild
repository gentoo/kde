# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kphotoalbum/kphotoalbum-4.2.ebuild,v 1.3 2013/02/09 23:42:18 dilfridge Exp $

EAPI=4

KDE_LINGUAS="ar be bg bs ca ca@valencia cs da de el en_GB eo es et eu fi fr ga gl
hi hne hr hu is it ja km lt mai nb nds nl nn pa pl pt pt_BR ro ru se sk sv tr ug uk
vi zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="KDE Photo Album is a tool for indexing, searching, and viewing images."
HOMEPAGE="http://www.kphotoalbum.org/"
SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2 FDL-1.2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug +exif +geolocation +kipi +raw +semantic-desktop"

DEPEND="
	$(add_kdebase_dep kdelibs 'semantic-desktop=')
	>=x11-libs/qt-sql-4.4:4[sqlite]
	virtual/jpeg
	exif? ( >=media-gfx/exiv2-0.17 )
	geolocation? ( $(add_kdebase_dep marble) )
	kipi? ( $(add_kdebase_dep libkipi '' 4.9.58) )
	raw? ( $(add_kdebase_dep libkdcraw '' 4.9.58) )
"
RDEPEND="${DEPEND}
	semantic-desktop? ( $(add_kdebase_dep nepomuk) )
"

DOCS=( ChangeLog README TODO )

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with exif Exiv2)
		$(cmake-utils_use_with geolocation Marble)
		$(cmake-utils_use_with kipi)
		$(cmake-utils_use_with raw Kdcraw)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)
	)

	kde4-base_src_configure
}
