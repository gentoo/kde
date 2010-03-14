# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="Nepomuk KDE4 client"
KEYWORDS=""
IUSE="debug +handbook"

DEPEND="
	>=app-misc/strigi-0.6.3[dbus,qt4]
	>=dev-libs/soprano-2.3.70[dbus,raptor,redland,virtuoso]
	$(add_kdebase_dep kdelibs 'semantic-desktop')
"
RDEPEND="${DEPEND}"

# BLOCKS:
# kde-base/akonadi: installed nepomuk ontologies, which were supposed to be here
add_blocker akonadi '<4.2.60'
