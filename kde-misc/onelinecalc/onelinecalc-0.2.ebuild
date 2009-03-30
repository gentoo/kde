# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="KDE4 plasmoid. Calculator consisting of a one line edit widget"
HOMEPAGE="http://www.kde-look.org/content/show.php/One-Line+Calculator?content=89524"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/89524-${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

RDEPEND="
	!kde-plasmoids/onelinecalc
	>=kde-base/plasma-workspace-${KDE_MINIMAL}
"

PATCHES=( "${FILESDIR}/cmake_fix_for_kde-4_2.patch" )
