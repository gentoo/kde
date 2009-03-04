# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="A newsreader for KDE"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"

DEPEND="
	>=kde-base/libkdepim-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libkpgp-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	libkdepim/
	libkpgp/
"

KMLOADLIBS="libkdepim"
