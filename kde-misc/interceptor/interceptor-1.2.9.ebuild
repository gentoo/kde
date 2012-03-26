# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit kde4-base

DESCRIPTION="Plasmoid intercepting log info from syslog"
HOMEPAGE="http://skylendar.kde.org/interceptor/"
SRC_URI="http://skylendar.kde.org/interceptor/${P}.tar.bz2"

SLOT="4"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}
     $(add_kdebase_dep plasma-workspace)
"

S="${WORKDIR}/${PN}"
