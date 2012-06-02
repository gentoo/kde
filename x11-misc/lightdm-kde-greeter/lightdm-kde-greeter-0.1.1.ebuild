# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_MINIMAL="4.8"

inherit kde4-base

MY_PN=${PN/-greeter/}
MY_P=${MY_PN}-${PV}

DESCRIPTION="LightDM KDE Greeter"
HOMEPAGE="http://kde.org/"
SRC_URI="http://download.kde.org/unstable/${MY_PN}/src/${MY_P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~amd64"
SLOT="0"
IUSE="debug"

S=$WORKDIR/${MY_P}

DEPEND="x11-misc/lightdm[qt4]"
RDEPEND="${DEPEND}"
