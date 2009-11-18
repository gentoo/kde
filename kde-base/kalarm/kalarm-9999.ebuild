# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="Personal alarm message, command and email scheduler for KDE"
KEYWORDS=""
IUSE="debug +handbook"

COMMON_DEPEND="
	$(add_kdebase_dep libkdepim)
"
DEPEND="${COMMON_DEPEND}
	dev-libs/libxslt
"
RDEPEND="${COMMON_DEPEND}"

KMEXTRACTONLY="
	kmail/
"

src_configure() {
	mycmakeargs="
		-DBUILD_akonadi=OFF
		-DXSLTPROC_EXECUTABLE=/usr/bin/xsltproc
	"
	kde4-meta_src_configure
}
