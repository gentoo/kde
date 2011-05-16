# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_LINGUAS="ar be ca ca@valencia cs da de el en_GB eo es et fi fr ga gl hr hu
ia it ja kk km ko lt lv mai nb nds nl nn pa pl pt pt_BR ro ru se sk sl sv th
tr uk zh_CN zh_TW"
KMNAME="kdepim-runtime"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE PIM runtime plugin collection"
KEYWORDS=""
IUSE="debug"

RESTRICT="test"
# Would need test programs _testrunner and akonaditest from kdepimlibs, see bug 313233

DEPEND="
	app-misc/strigi
	>=app-office/akonadi-server-1.3.60
	dev-libs/boost
	dev-libs/libxml2:2
	dev-libs/libxslt
	>=dev-libs/shared-desktop-ontologies-0.6.51
	$(add_kdebase_dep kdepimlibs 'semantic-desktop')
	x11-misc/shared-mime-info
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdepim-icons)
"

add_blocker kdemaildir '<4.3.0'
add_blocker akonadi '<4.3.90'
