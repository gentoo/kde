# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_LINGUAS="de pl"
inherit kde4-base

MY_P="kde4-windeco-${P}-Source"

DESCRIPTION="Window decoration (oxygen fork) for KDE 4"
HOMEPAGE="http://www.kde-look.org/content/show.php/Nitrogen?content=99551"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/99551-${MY_P}.tar.gz"

S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"
