# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KDE_MINIMAL="4.2"
inherit kde4-base

DESCRIPTION="KDE4 plasmoid. Add files over KIO supported protocols, like ftp and ssh."
HOMEPAGE="http://www.kde-look.org/content/show.php/Drop2FTP?content=97281"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/97281-${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=kde-base/plasma-workspace-${KDE_MINIMAL}"
RDEPEND="${DEPEND}
	!kde-plasmoids/drop2ftp"
