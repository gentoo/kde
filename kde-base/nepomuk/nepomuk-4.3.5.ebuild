# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="Nepomuk KDE4 client"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

DEPEND="
	|| (
		>=dev-libs/soprano-2.3.0[dbus,raptor,java]
		>=dev-libs/soprano-2.3.0[dbus,raptor,redland]
	)
	$(add_kdebase_dep kdelibs 'semantic-desktop')
"
# BLOCKS:
# kde-base/akonadi: installed nepomuk ontologies, which were supposed to be here
add_blocker akonadi '<4.2.60'
