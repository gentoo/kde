# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KDE_MINIMAL="4.2"

inherit kde4-base versionator

MY_PV=$(replace_version_separator . '')
MY_P=${PN}${MY_PV}

DESCRIPTION="A KDE4 Plasma Applet. This plasmoid shows TV stations program in Greek."
HOMEPAGE="http://www.kde-look.org/content/show.php/Eyesaver?content=75728"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/75728-${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${PN}"
