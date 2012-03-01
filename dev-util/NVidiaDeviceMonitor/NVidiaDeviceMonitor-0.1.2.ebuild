# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit kde4-base

DESCRIPTION="Displays card model, temperature and gpu\'s memory occupation"
HOMEPAGE="http://kde-apps.org/content/show.php/NVidia+Device+Monitor?content=148658"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/148658-${P}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"

SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND} x11-drivers/nvidia-drivers"

S="${WORKDIR}/${P}"

src_unpack() {
	mkdir ${S} && cd ${S} || die
	ls -ld ${P}
	kde4-base_src_unpack
	mv ${PN}/* . || die
	rmdir ${PN}
}

