# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_MINIMAL="4.2"
inherit kde4-base versionator

MY_P="$(replace_version_separator 2 '-')"

DESCRIPTION="KDE4 plasmoid for executing a process and captures its stderr and stdout."
HOMEPAGE="http://www.kde-look.org/content/show.php/STDIN+Plasmoid?content=92309"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/92309-${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="!kde-plasmoids/stdin-plasmoid"

S="${WORKDIR}/${MY_P}"
