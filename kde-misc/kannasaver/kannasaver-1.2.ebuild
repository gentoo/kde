# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_MINIMAL=4.6
inherit kde4-base

RESTRICT="$RESTRICT mirror"

DESCRIPTION="Kannasaver is a screensaver for people who want to learn Japanese"
HOMEPAGE="http://kde-look.org/content/show.php/kannasaver?content=16792"
SRC_URI="http://kde-look.org/CONTENT/content-files/16792-${P}.tar.gz"

S="${WORKDIR}/home/fs/release_mgmt/${P}"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kscreensaver)
"
