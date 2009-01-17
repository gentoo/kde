# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-apps"
inherit kde4-meta

DESCRIPTION="A KDE filemanager focusing on usability"
KEYWORDS=""
IUSE="debug htmlhandbook +semantic-desktop"

DEPEND="
	kde-base/kdelibs:${SLOT}[semantic-desktop=]
	>=kde-base/libkonq-${PV}:${SLOT}
	semantic-desktop? ( >=kde-base/nepomuk-${PV}:${SLOT} )
"
RDEPEND="${DEPEND}"

KMEXTRA="
	doc/${PN}
"

KMLOADLIBS="libkonq"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)"

	kde4-meta_src_configure
}
