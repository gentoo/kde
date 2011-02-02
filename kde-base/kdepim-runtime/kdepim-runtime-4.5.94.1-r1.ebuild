# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

KMNAME="kdepim-runtime"

inherit kde4-meta

DESCRIPTION="KDE PIM runtime plugin collection"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RESTRICT="test"
# Would need test programs _testrunner and akonaditest from kdepimlibs, see bug 313233

DEPEND="
	app-misc/strigi
	>=app-office/akonadi-server-1.3.60
	dev-libs/boost
	dev-libs/libxml2:2
	dev-libs/libxslt
	$(add_kdebase_dep kdepimlibs 'semantic-desktop')
	x11-misc/shared-mime-info
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdepim-icons)
"

add_blocker kdemaildir '<4.3.0'
add_blocker akonadi '<4.3.90'
