# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit kde4-meta-pkg

DESCRIPTION="KDE - merge this to pull in all split kde-base/* packages"
KEYWORDS=""
IUSE="accessibility kdepim minimal nls sdk"

RDEPEND="
	$(add_kdeapps_dep kate)
	$(add_kdeapps_dep kdeadmin-meta)
	$(add_kdeapps_dep kdeartwork-meta)
	$(add_kdeapps_dep kdebase-meta)
	$(add_kdeapps_dep kdeedu-meta)
	$(add_kdeapps_dep kdegames-meta)
	$(add_kdeapps_dep kdegraphics-meta)
	$(add_kdeapps_dep kdemultimedia-meta)
	$(add_kdeapps_dep kdenetwork-meta)
	$(add_kdeapps_dep kdetoys-meta)
	$(add_kdeapps_dep kdeutils-meta)
	accessibility? ( $(add_kdeapps_dep kdeaccessibility-meta) )
	kdepim? ( $(add_kdeapps_dep kdepim-meta "" 4.4.11.1) )
	nls? ( $(add_kdeapps_dep kde-l10n) )
	sdk? (
		$(add_kdeapps_dep kdebindings-meta)
		$(add_kdeapps_dep kdesdk-meta)
		$(add_kdeapps_dep kdewebdev-meta)
	)
	!minimal? ( $(add_kdeapps_dep kdeplasma-addons) )
"
