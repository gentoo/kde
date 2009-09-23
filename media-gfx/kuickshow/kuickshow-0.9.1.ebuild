# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

KDE_LINGUAS="ar bg br cs cy da de el en_GB es et fr ga gl hi hu it ja ka lt nb
nds nl pl pt pt_BR ro ru rw sv ta tg tr uk zh_CN"
KDE_MINIMAL="4.3"
inherit kde4-base

MY_P="${P}-kde4.3.1"
DESCRIPTION="KDE4 program to view images"
HOMEPAGE="http://userbase.kde.org/KuickShow"
SRC_URI="ftp://ftp.kde.org/pub/kde/stable/latest/src/extragear/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug handbook"

DEPEND="media-libs/imlib"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
