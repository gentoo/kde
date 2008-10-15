# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

NEED_KDE=":4.1"
inherit kde4-base

DESCRIPTION="A KDE4 Plasma Applet. A variation of the KAlgebra plasmoid that makes use of the Qalculate! library."
HOMEPAGE="http://www.kde-look.org/content/show.php/Qalculate?content=84618"
KEYWORDS="~amd64 ~x86"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/84618-qalculate_applet-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="4.1"
IUSE=""

DEPEND="!kde-misc/plasmoids
		kde-base/libplasma"

S="${WORKDIR}/qalculate_applet"
