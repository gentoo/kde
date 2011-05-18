# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit kde4-base

RESTRICT="$RESTRICT mirror"

DESCRIPTION="Titlebar-less decoration, inspired by Google Chrome, and Nitrogen minimal mod"
HOMEPAGE="http://kde-look.org/content/show.php/Chromi?content=119069"
SRC_URI="https://download.github.com/jinliu-kwin-deco-chromi-v0.2-0-g4390e63.tar.gz"

SLOT="4"
LICENSE="GPL-2"
KEYWORDS="amd64 ~x86"
IUSE=""

S="${WORKDIR}/jinliu-kwin-deco-chromi-4390e63"

DEPEND="$(add_kdebase_dep kwin "" 4.4.1)"
RDEPEND="${DEPEND}"
