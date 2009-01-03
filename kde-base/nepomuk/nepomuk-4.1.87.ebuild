# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="Nepomuk KDE4 client"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

# dev-cpp/clucene provides the optional strigi backend.
# As there's currently no other *usable* strigi backend, I've added it as a hard
# dependency.
DEPEND="dev-cpp/clucene
		dev-libs/soprano[clucene]"
RDEPEND="${DEPEND}"
