# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="Nepomuk KDE4 client"
KEYWORDS=""
IUSE="debug"

DEPEND="
	>=app-misc/strigi-0.7.7[dbus,qt4]
	>=dev-libs/soprano-2.8.0[dbus,raptor,redland,virtuoso]
	$(add_kdebase_dep kdelibs 'semantic-desktop')
	$(add_kdebase_dep nepomuk-core)
	!kde-misc/nepomukcontroller
	!~dev-db/virtuoso-server-6.1.5
	!~dev-db/virtuoso-odbc-6.1.5
	!~dev-db/virtuoso-jdbc-6.1.5
"
RDEPEND="${DEPEND}"

RESTRICT="test"
# bug 392989
