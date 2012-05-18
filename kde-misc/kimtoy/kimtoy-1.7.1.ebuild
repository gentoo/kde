# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit kde4-base

DESCRIPTION="KIMToy is an input method frontend for KDE"
HOMEPAGE="http://kde-apps.org/content/show.php/KIMToy?content=140967"
SRC_URI="http://kde-apps.org/CONTENT/content-files/140967-${P}.tar.bz2"

SLOT="4"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	$(add_kdebase_dep plasma-workspace)
"
