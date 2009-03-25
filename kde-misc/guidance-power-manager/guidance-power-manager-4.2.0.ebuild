# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KDE_MINIMAL="4.2"
KDE_LINGUAS="be cs da de el es et fr ga gl it ja km lt lv
			nb nds nl nn pa pl pt pt_BR ro sk sv tr uk wa zh_CN zh_TW"

inherit kde4-base

KDE_VERSION="4.2.0"

DESCRIPTION="KDE Power Manager control module"
HOMEPAGE="http://www.kde.org"
SRC_URI="mirror://kde/stable/${KDE_VERSION}/src/extragear/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"
