# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit kde4-base

MY_P="${PN}/${PN}-0.1"

DESCRIPTION="KDE4 plasmoid. Reminds us to take our eyes off the screen"
HOMEPAGE="http://www.kde-look.org/content/show.php/Eyesaver?content=89989"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/89989-${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

RDEPEND="
	!kde-plasmoids/eyesaver
	$(add_kdebase_dep plasma-workspace)
"

S="${WORKDIR}/${MY_P}"

PATCHES=( 
	"${FILESDIR}/cmake_fix_for_kde-4_2.patch"
	"${FILESDIR}/eyesaver-0.2a-fix.patch"
)
