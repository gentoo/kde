# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DECLARATIVE_REQUIRED="always"
inherit kde4-base

DESCRIPTION="IDE for writing KDE Plasma/KWin components (themes, Plasmoids, runners, data engines)"
HOMEPAGE="https://projects.kde.org/projects/extragear/sdk/plasmate"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS=""
IUSE="debug"

DEPEND="
	app-crypt/gpgme
	dev-libs/libattica[qt4]
	dev-libs/soprano
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep knewstuff)
"

RDEPEND="
	${DEPEND}
	dev-vcs/git
"
