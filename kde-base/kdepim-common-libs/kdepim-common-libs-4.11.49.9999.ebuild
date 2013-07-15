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
	>=app-office/akonadi-server-1.9.52
	dev-libs/grantlee
	>=dev-libs/shared-desktop-ontologies-0.11.0
	$(add_kdebase_dep kdepimlibs)
"
RDEPEND="${DEPEND}
	!kde-base/akonadi:4
	!kde-base/libkdepim:4
	!kde-base/libkleo:4
	!kde-base/libkpgp:4
	!<kde-base/kaddressbook-4.4.90:4
	!kde-base/kdepim-wizards:4
	!<kde-base/kmail-4.4.80:4
	!<kde-base/korganizer-4.5.67:4
	app-crypt/gnupg
	$(add_kdebase_dep kdepim-runtime)
"

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
	sendlateragent/
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

PATCHES=( "${FILESDIR}/install-composereditorng.patch" )
