# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="KDE4 plasmoid that shows CPU load on the screen."
HOMEPAGE="http://www.kde-look.org/content/show.php/cpuload?content=86628"
SRC_URI="http://kde-look.org/CONTENT/content-files/86628-${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

RDEPEND="
	!kde-plasmoids/cpuload
	>=kde-base/plasma-workspace-${KDE_MINIMAL}
"

S="${WORKDIR}"/"${PN}"
