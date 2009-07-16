# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="Multimedia Player Plasmoid"
HOMEPAGE="http://kde-look.org/CONTENT/content-files/95501-miniplayer-0.9.5.tar.bz2"
SRC_URI="http://kde-look.org/CONTENT/content-files/95501-${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

RDEPEND="
	>=kde-base/plasma-workspace-${KDE_MINIMAL}
"
