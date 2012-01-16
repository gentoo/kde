# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"

inherit kde4-base

DESCRIPTION="Qt interface to the Zeitgeist event tracking system"
HOMEPAGE="https://projects.kde.org/projects/kdesupport/libqzeitgeist"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
else
	KEYWORDS=""
fi

LICENSE="GPL-2"
SLOT="4"
IUSE="debug"

DEPEND="
	dev-libs/libzeitgeist
"
RDEPEND="${DEPEND}"
