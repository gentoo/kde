# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-meta/kdebase-meta-4.2.4.ebuild,v 1.2 2009/06/04 23:32:13 alexxy Exp $

EAPI="2"
inherit kde4-functions

DESCRIPTION="Merge this to pull in all kdebase-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="live"
KEYWORDS=""
IUSE="kdeprefix policykit +semantic-desktop"

RDEPEND="
	$(add_kdebase_dep dolphin)
	$(add_kdebase_dep drkonqi)
	$(add_kdebase_dep kappfinder)
	$(add_kdebase_dep kcheckpass)
	$(add_kdebase_dep kcminit)
	$(add_kdebase_dep kcmshell)
	$(add_kdebase_dep kcontrol)
	$(add_kdebase_dep kdebase-cursors)
	$(add_kdebase_dep kdebase-data)
	$(add_kdebase_dep kdebase-desktoptheme)
	$(add_kdebase_dep kdebase-kioslaves)
	$(add_kdebase_dep kdebase-menu)
	$(add_kdebase_dep kdebase-menu-icons)
	$(add_kdebase_dep kdebase-startkde)
	$(add_kdebase_dep kdebase-wallpapers)
	$(add_kdebase_dep kdebugdialog)
	$(add_kdebase_dep kdepasswd)
	$(add_kdebase_dep kdesu)
	$(add_kdebase_dep kdialog)
	$(add_kdebase_dep kdm)
	$(add_kdebase_dep keditbookmarks)
	$(add_kdebase_dep keditfiletype)
	$(add_kdebase_dep kephal)
	$(add_kdebase_dep kfile)
	$(add_kdebase_dep kfind)
	$(add_kdebase_dep kfmclient)
	$(add_kdebase_dep kglobalaccel)
	$(add_kdebase_dep khelpcenter)
	$(add_kdebase_dep khotkeys)
	$(add_kdebase_dep kiconfinder)
	$(add_kdebase_dep kinfocenter)
	$(add_kdebase_dep kioclient)
	$(add_kdebase_dep klipper)
	$(add_kdebase_dep kmenuedit)
	$(add_kdebase_dep kmimetypefinder)
	$(add_kdebase_dep knetattach)
	$(add_kdebase_dep knewstuff)
	$(add_kdebase_dep konqueror)
	$(add_kdebase_dep konsole)
	$(add_kdebase_dep kpasswdserver)
	$(add_kdebase_dep kquitapp)
	$(add_kdebase_dep kscreensaver)
	$(add_kdebase_dep ksmserver)
	$(add_kdebase_dep ksplash)
	$(add_kdebase_dep kstart)
	$(add_kdebase_dep kstartupconfig)
	$(add_kdebase_dep kstyles)
	$(add_kdebase_dep ksysguard)
	$(add_kdebase_dep ksystraycmd)
	$(add_kdebase_dep ktimezoned)
	$(add_kdebase_dep ktraderclient)
	$(add_kdebase_dep kuiserver)
	$(add_kdebase_dep kurifilter-plugins)
	$(add_kdebase_dep kwalletd)
	$(add_kdebase_dep kwin)
	$(add_kdebase_dep kwrite)
	$(add_kdebase_dep kwrited)
	$(add_kdebase_dep libkonq)
	$(add_kdebase_dep libkworkspace)
	$(add_kdebase_dep libplasmaclock)
	$(add_kdebase_dep libtaskmanager)
	$(add_kdebase_dep nsplugins)
	$(add_kdebase_dep phonon-kde)
	$(add_kdebase_dep plasma-apps)
	$(add_kdebase_dep plasma-runtime)
	$(add_kdebase_dep plasma-workspace)
	$(add_kdebase_dep powerdevil)
	$(add_kdebase_dep renamedlg-plugins)
	$(add_kdebase_dep solid)
	$(add_kdebase_dep solid-hardware)
	$(add_kdebase_dep solidautoeject)
	$(add_kdebase_dep soliduiserver)
	$(add_kdebase_dep systemsettings)
	policykit? ( $(add_kdebase_dep policykit-kde) )
	semantic-desktop? ( $(add_kdebase_dep nepomuk) )
	$(block_other_slots)
"

add_blocker kdebase-runtime-meta
add_blocker kdebase-workspace-meta
