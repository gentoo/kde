# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
SLOT="kde-svn"
KMNAME=koffice
inherit kde4svn-meta

DESCRIPTION="KOffice formula editor."
KEYWORDS=""
IUSE=""

DEPEND=">=app-office/koffice-libs-${PV}:${SLOT}"
RDEPEND=${DEPEND}

KMEXTRA="filters/kformula/
	doc/koffice/"
KMEXTRACTONLY="libs/"
KMCOPYLIB="libko"

src_compile() {
	epatch "${FILESDIR}"/${P}-link_lib.patch

	kde4overlay-meta_src_compile
}
