# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="A KDE4 Plasma Applet. A variation of the KAlgebra plasmoid that makes use of the Qalculate! library."
HOMEPAGE="http://www.kde-look.org/content/show.php/Qalculate?content=84618"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/84618-${P/-/_}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="!kde-misc/plasmoids
		kde-base/libplasma
		sci-libs/libqalculate"

S="${WORKDIR}/${PN/-/_}"
