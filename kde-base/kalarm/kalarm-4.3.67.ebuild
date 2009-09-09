# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="Personal alarm message, command and email scheduler for KDE"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug +handbook"

COMMON_DEPEND="
	>=kde-base/libkdepim-${PV}:${SLOT}[kdeprefix=]
"
DEPEND="${COMMON_DEPEND}
	dev-libs/libxslt
"
RDEPEND="${COMMON_DEPEND}"

KMEXTRACTONLY="
	akonadi/
	kmail/
"

src_configure() {
	mycmakeargs="
		-DBUILD_akonadi=ON
		-DXSLTPROC_EXECUTABLE=/usr/bin/xsltproc
	"
	kde4-meta_src_configure
}
