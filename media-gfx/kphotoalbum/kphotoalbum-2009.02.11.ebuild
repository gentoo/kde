# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base versionator

MY_P="${PN}-$(replace_all_version_separators '-')"

DESCRIPTION="KDE Photo Album is a tool for indexing, searching, and viewing images."
HOMEPAGE="http://www.kphotoalbum.org/"
SRC_URI="http://dev.gentoo.org/~jkt/kphotoalbum/${MY_P}.tar.bz2"

SLOT="4"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="+exif +kipi +marble +raw +semantic-desktop"

DEPEND="
	>=kde-base/kdelibs-${KDE_MINIMAL}[kdeprefix=,semantic-desktop?]
	media-libs/jpeg
	x11-libs/qt-sql:4[sqlite]
	exif? ( >=media-gfx/exiv2-0.17 )
	kipi? ( >=kde-base/libkipi-${KDE_MINIMAL}[kdeprefix=] )
	marble? ( >=kde-base/marble-${KDE_MINIMAL}[kdeprefix=] )
	raw? ( >=kde-base/libkdcraw-${KDE_MINIMAL}[kdeprefix=] )
"
RDEPEND="${DEPEND}
	semantic-desktop? ( >=kde-base/nepomuk-${KDE_MINIMAL}[kdeprefix=] )
"

S="${WORKDIR}"/${MY_P}
