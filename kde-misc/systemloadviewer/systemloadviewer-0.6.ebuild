# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="KDE4 plasmoid. This plasmoid shows cpu, ram, and swap usage."
HOMEPAGE="http://www.kde-look.org/content/show.php?content=74891"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/74891-${PN}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

RDEPEND="
	!kde-plasmoids/systemloadviewer
	>=kde-base/plasma-workspace-${KDE_MINIMAL}
"

S="${WORKDIR}/${PN}"
