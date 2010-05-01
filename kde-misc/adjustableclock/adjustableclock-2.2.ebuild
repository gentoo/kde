# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="Plasmoid to show date and time in adjustable format using rich text."
HOMEPAGE="http://kde-look.org/content/show.php/Adjustable+Clock?content=92825"
SRC_URI="http://kde-look.org/CONTENT/content-files/92825-${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="$(add_kdebase_dep plasma-workspace)"
DEPEND="$(add_kdebase_dep libplasmaclock)"
