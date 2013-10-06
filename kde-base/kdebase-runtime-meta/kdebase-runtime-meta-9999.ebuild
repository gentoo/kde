# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit kde4-meta-pkg

DESCRIPTION="Merge this to pull in all kdebase-runtime-derived packages"
KEYWORDS=""
IUSE="+handbook semantic-desktop"

RDEPEND="
	$(add_kdebase_dep attica)
	$(add_kdebase_dep drkonqi)
	$(add_kdebase_dep kcmshell)
	$(add_kdebase_dep kcontrol)
	$(add_kdebase_dep kdebase-data)
	$(add_kdebase_dep kdebase-desktoptheme)
	$(add_kdebase_dep kdebase-kioslaves)
	$(add_kdebase_dep kdebase-menu)
	$(add_kdebase_dep kdebase-menu-icons)
	$(add_kdebase_dep kdebugdialog)
	$(add_kdebase_dep kdesu)
	$(add_kdebase_dep kdontchangethehostname)
	$(add_kdebase_dep keditfiletype)
	$(add_kdebase_dep kfile)
	$(add_kdebase_dep kglobalaccel)
	$(add_kdebase_dep kiconfinder)
	$(add_kdebase_dep kimgio)
	$(add_kdebase_dep kioclient)
	$(add_kdebase_dep kmimetypefinder)
	$(add_kdebase_dep knetattach)
	$(add_kdebase_dep knewstuff)
	$(add_kdebase_dep kpasswdserver)
	$(add_kdebase_dep kquitapp)
	$(add_kdebase_dep kstart)
	$(add_kdebase_dep ktimezoned)
	$(add_kdebase_dep ktraderclient)
	$(add_kdebase_dep kuiserver)
	$(add_kdebase_dep kurifilter-plugins)
	$(add_kdebase_dep kwallet)
	$(add_kdebase_dep kwalletd)
	$(add_kdebase_dep plasma-runtime)
	$(add_kdebase_dep renamedlg-plugins)
	$(add_kdebase_dep solid-runtime)
	handbook? ( $(add_kdebase_dep khelpcenter) )
	semantic-desktop? ( $(add_kdebase_dep nepomuk) )
"
