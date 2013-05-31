# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="Akonadi developer console"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs 'semantic-desktop(+)')
	$(add_kdebase_dep kdepim-common-libs)
	$(add_kdebase_dep nepomuk-core)
	$(add_kdebase_dep nepomuk-widgets)
	app-office/akonadi-server
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	akonadi_next/
	calendarsupport/
	messageviewer/
"
