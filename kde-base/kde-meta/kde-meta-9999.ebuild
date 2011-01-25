# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit kde4-functions

DESCRIPTION="KDE - merge this to pull in all split kde-base/* packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="live"
KEYWORDS=""
IUSE="accessibility aqua kdeprefix nls sdk semantic-desktop"

RDEPEND="
	$(add_kdebase_dep kate)
	$(add_kdebase_dep kdeadmin-meta)
	$(add_kdebase_dep kdeartwork-meta)
	$(add_kdebase_dep kdebase-meta)
	$(add_kdebase_dep kdeedu-meta)
	$(add_kdebase_dep kdegames-meta)
	$(add_kdebase_dep kdegraphics-meta)
	$(add_kdebase_dep kdemultimedia-meta)
	$(add_kdebase_dep kdenetwork-meta)
	$(add_kdebase_dep kdeplasma-addons)
	$(add_kdebase_dep kdetoys-meta)
	$(add_kdebase_dep kdeutils-meta)
	accessibility? ( $(add_kdebase_dep kdeaccessibility-meta) )
	nls? ( $(add_kdebase_dep kde-l10n) )
	sdk? (
		$(add_kdebase_dep kdebindings-meta)
		$(add_kdebase_dep kdesdk-meta)
		$(add_kdebase_dep kdewebdev-meta)
	)
	semantic-desktop? ( $(add_kdebase_dep kdepim-meta) )
	$(block_other_slots)
"
