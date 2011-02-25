# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit kde4-base

KDE_LOOK="117147"

DESCRIPTION="Colibri provides an alternative to KDE4 Plasma notifications."
HOMEPAGE="http://www.kde-look.org/content/show.php?content=${KDE-LOOK}"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/${KDE_LOOK}-${P}.tar.bz2"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=kde-base/kdelibs-4.4"
RDEPEND="${DEPEND}"

