# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_LINGUAS="cs af es de ru sl fr it sk"
inherit kde4-base

DESCRIPTION="yaWP (Yet Another Weather Plasmoid)"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=94106"
SRC_URI="http://marian.kyralovi.cz/data/yawp/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${DEPEND}"

S="${WORKDIR}"/"${P}"
