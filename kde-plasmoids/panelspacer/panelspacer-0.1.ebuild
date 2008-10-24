# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
NEED_KDE=":4.1"

inherit kde4-base

DESCRIPTION="A KDE4 Plasma Applet let you put some blank space between the other applets located in a panel"
HOMEPAGE="http://www.kde-look.org/content/show.php/Panel+Spacer?content=89304"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/89304-${PN}${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="4.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="!kde-misc/plasmoids
		kde-base/libplasma"

S="${WORKDIR}/plasmaspacer_0.1"
