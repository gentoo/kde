# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

MY_PN="todo_plasmoid"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="KDE4 plasmoid that shows a 'todo' list, using the korganizer 'Active calendar' resource file."
HOMEPAGE="http://kde-look.org/content/show.php/todo+list?content=90706"
SRC_URI="http://kde-look.org/CONTENT/content-files/90706-${MY_P}.tar.bz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=kde-base/plasma-workspace-${KDE_MINIMAL}"
RDEPEND="${DEPEND}
	!kde-plasmoids/todo_plasmoid"

PATCHES=( "${FILESDIR}/${P}-patch_kde42.diff" )

S="${WORKDIR}/${MY_PN}"
