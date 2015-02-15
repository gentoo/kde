# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-meta/kdebase-meta-4.14.3.ebuild,v 1.3 2015/02/14 14:35:11 ago Exp $

EAPI=5
inherit kde4-meta-pkg

DESCRIPTION="Merge this to pull in all kdebase-derived packages"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="+display-manager minimal +wallpapers"

RDEPEND="
	$(add_kdebase_dep dolphin)
	$(add_kdebase_dep kcheckpass '' 4.11)
	wallpapers? ( $(add_kdebase_dep kde-wallpapers '' 4.11) )
	$(add_kdebase_dep kde-base-artwork)
	$(add_kdebase_dep kdebase-runtime-meta)
	$(add_kdebase_dep kdialog)
	$(add_kdebase_dep keditbookmarks)
	$(add_kdebase_dep kephal '' 4.11)
	$(add_kdebase_dep kfind)
	$(add_kdebase_dep kfmclient)
	$(add_kdebase_dep konq-plugins)
	$(add_kdebase_dep konqueror)
	$(add_kdebase_dep konsole)
	$(add_kdebase_dep kscreensaver '' 4.11)
	$(add_kdebase_dep kstartupconfig '' 4.11)
	$(add_kdebase_dep kstyles '' 4.11)
	$(add_kdebase_dep ksystraycmd '' 4.11)
	$(add_kdebase_dep kwrite)
	$(add_kdebase_dep libkonq)
	$(add_kdebase_dep liboxygenstyle '' 4.11)
	$(add_kdebase_dep libplasmaclock '' 4.11)
	$(add_kdebase_dep nsplugins)
	$(add_kdebase_dep phonon-kde)
	$(add_kdebase_dep plasma-apps)
	$(add_kdebase_dep qguiplatformplugin_kde '' 4.11)
	!minimal? (
		$(add_kdebase_dep freespacenotifier '' 4.11)
		$(add_kdebase_dep kcminit '' 4.11)
		$(add_kdebase_dep kdebase-cursors '' 4.11)
		$(add_kdebase_dep kdebase-startkde '' 4.11)
		$(add_kdebase_dep kdepasswd)
		$(add_kdebase_dep khotkeys '' 4.11)
		$(add_kdebase_dep kinfocenter '' 4.11)
		$(add_kdebase_dep klipper '' 4.11)
		$(add_kdebase_dep kmenuedit '' 4.11)
		$(add_kdebase_dep krunner '' 4.11)
		$(add_kdebase_dep ksmserver '' 4.11)
		$(add_kdebase_dep ksplash '' 4.11)
		$(add_kdebase_dep ksysguard '' 4.11)
		$(add_kdebase_dep kwin '' 4.11)
		$(add_kdebase_dep kwrited '' 4.11)
		$(add_kdebase_dep libkworkspace '' 4.11)
		$(add_kdebase_dep libplasmagenericshell '' 4.11)
		$(add_kdebase_dep libtaskmanager '' 4.11)
		$(add_kdebase_dep plasma-workspace '' 4.11)
		$(add_kdebase_dep powerdevil '' 4.11)
		$(add_kdebase_dep solid-actions-kcm '' 4.11)
		$(add_kdebase_dep systemsettings '' 4.11)
		!prefix? ( display-manager? ( || ( $(add_kdebase_dep kdm '' 4.11) x11-misc/lightdm x11-misc/sddm ) ) )
	)
"
