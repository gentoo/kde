# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="KDE plasmoid. Shows an icon-only taskbar"
HOMEPAGE="http://www.kde-look.org/content/show.php/STasks?content=99739"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/99739-${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

RDEPEND="
	!kde-plasmoids/stasks
	>=kde-base/plasma-workspace-${KDE_MINIMAL}
"
