# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base versionator

MY_P="${PN}-$(replace_all_version_separators '-')"

DESCRIPTION="KDE Photo Album is a tool for indexing, searching, and viewing images."
HOMEPAGE="http://www.kphotoalbum.org/"
SRC_URI="http://dev.gentoo.org/~jkt/kphotoalbum/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug +exif +geolocation +kipi +raw +semantic-desktop"

DEPEND="
	>=kde-base/kdelibs-${KDE_MINIMAL}[kdeprefix=,semantic-desktop?]
	media-libs/jpeg
	>=x11-libs/qt-sql-4.4:4[sqlite]
	exif? ( >=media-gfx/exiv2-0.17 )
	geolocation? ( >=kde-base/marble-${KDE_MINIMAL}[kdeprefix=] )
	kipi? ( >=kde-base/libkipi-${KDE_MINIMAL}[kdeprefix=] )
	raw? ( >=kde-base/libkdcraw-${KDE_MINIMAL}[kdeprefix=] )
"
RDEPEND="${DEPEND}
	semantic-desktop? ( >=kde-base/nepomuk-${KDE_MINIMAL}[kdeprefix=] )
"

S="${WORKDIR}"/${MY_P}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with exif Exiv2)
		$(cmake-utils_use_with raw Kdcraw)
		$(cmake-utils_use_with kipi Kipi)
		$(cmake-utils_use_with geolocation Marble)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)"

	kde4-base_src_configure
}
