# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdepim
inherit kde4-meta

DESCRIPTION="KDE news feed aggregator."
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

DEPEND=">=kde-base/libkdepim-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libkdepim/"
KMLOADLIBS="libkdepim"
