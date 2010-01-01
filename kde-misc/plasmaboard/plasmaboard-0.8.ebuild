# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_MINIMAL="4.3"
inherit kde4-base

DESCRIPTION="A virtual keyboard for KDE 4's plasma desktop"
HOMEPAGE="http://www.kde-look.org/content/show.php/Plasmaboard?content=101822"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/101822-${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

S="${WORKDIR}"/"${PN}"
