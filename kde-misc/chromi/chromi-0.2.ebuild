# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit kde4-base

RESTRICT="$RESTRICT mirror"

DESCRIPTION="Titlebar-less decoration, inspired by Google Chrome, and Nitrogen minimal mod"
HOMEPAGE="http://kde-look.org/content/show.php/Chromi?content=119069"
SRC_URI="http://github.com/jinliu/kwin-deco-chromi/archive/master.zip"

SLOT="4"
LICENSE="GPL-2"
KEYWORDS="amd64 ~x86"
IUSE=""

S="${WORKDIR}/kwin-deco-chromi-master"

DEPEND="$(add_kdebase_dep kwin)"
RDEPEND="${DEPEND}"
