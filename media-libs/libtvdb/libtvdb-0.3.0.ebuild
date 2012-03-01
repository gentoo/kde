# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit kde4-base

DESCRIPTION="A small Qt-based C++ library which allows to fetch TV series information from thetvdb.com"
HOMEPAGE="http://sourceforge.net/projects/libtvdb/"
SRC_URI="http://sourceforge.net/projects/libtvdb/files/latest/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
