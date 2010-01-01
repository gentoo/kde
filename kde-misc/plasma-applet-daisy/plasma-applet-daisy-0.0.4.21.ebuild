# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="A simple application launcher for KDE 4's plasma desktop"
HOMEPAGE="http://daisyplasma.freehostia.com/"
SRC_URI="http://daisyplasma.freehostia.com/downloads/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="!kde-misc/daisy"
