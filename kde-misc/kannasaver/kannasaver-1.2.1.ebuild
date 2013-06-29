# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_LINGUAS="cs da de en_GB es et hu it nb nds nl pt pt_BR ru sv th uk zh_TW"
inherit kde4-base

DESCRIPTION="KDE based screensaver for people who want to learn Japanese"
HOMEPAGE="http://kde-look.org/content/show.php/kannasaver?content=16792"
SRC_URI="http://kde-look.org/CONTENT/content-files/16792-${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kscreensaver)
"
RDEPEND="${DEPEND}"
