# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kdepim"
KMNOMODULE="true"
inherit kde4-meta

DESCRIPTION="Common libraries for KDE PIM apps"
KEYWORDS=""
IUSE="debug"

DEPEND="
	app-crypt/gpgme
	>=app-office/akonadi-server-1.9.0
	>=dev-libs/shared-desktop-ontologies-0.10.0
	$(add_kdebase_dep kdepimlibs 'semantic-desktop')
"
RDEPEND="${DEPEND}
	app-crypt/gnupg
	$(add_kdebase_dep kdepim-runtime)
"

# @Since >4.4.76 merged here
add_blocker akonadi
add_blocker libkdepim
add_blocker libkleo
add_blocker libkpgp
add_blocker kaddressbook '<4.4.90'
# kdepim-wizards removed since 4.8.0
add_blocker kdepim-wizards
add_blocker kmail '<4.4.80'
add_blocker korganizer '<4.5.67'

RESTRICT="test"
# bug 393131

KMEXTRA="
	akonadi_next/
	calendarsupport/
	calendarviews/
	composereditor-ng/
	incidenceeditor-ng/
	libkdepim/
	libkdepimdbusinterfaces/
	libkleo/
	libkpgp/
	kdgantt2/
	messagecomposer/
	messagecore/
	messagelist/
	messageviewer/
	ontologies/
	pimcommon/
	templateparser/
"

KMEXTRACTONLY="
	kleopatra/
	kmail/
	knode/org.kde.knode.xml
	korganizer/korgac/org.kde.korganizer.KOrgac.xml
	korganizer/org.kde.korganizer.Korganizer.xml
"

KMSAVELIBS="true"
