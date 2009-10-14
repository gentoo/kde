# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="A KDE4 Plasma Applet. This plasmoid shows cpu, ram, and swap usage."
HOMEPAGE="http://www.kde-look.org/content/show.php?content=74891"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/74891-systemloadviewer.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	>=kde-base/plasma-workspace-${KDE_MINIMAL}
"

S="${WORKDIR}/${PN}"
