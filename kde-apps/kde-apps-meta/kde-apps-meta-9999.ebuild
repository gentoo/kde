# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5-meta-pkg

DESCRIPTION="Meta package for the KDE Applications collection"
KEYWORDS=""
IUSE="accessibility nls sdk"

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
	nls? ( $(add_kdeapps_dep kde-l10n) )
	sdk? (
		$(add_kdeapps_dep kdesdk-meta)
		$(add_kdeapps_dep kdewebdev-meta)
	)
"
