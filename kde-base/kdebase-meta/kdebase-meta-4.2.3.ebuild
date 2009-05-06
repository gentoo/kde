# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-meta/kdebase-meta-4.2.2.ebuild,v 1.2 2009/04/17 06:13:50 alexxy Exp $

EAPI="2"

inherit kde4-functions

DESCRIPTION="Merge this to pull in all kdebase-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="semantic-desktop"

RDEPEND="
	!kde-base/kdebase-runtime-meta
	!kde-base/kdebase-workspace-meta
	>=kde-base/dolphin-${PV}:${SLOT}
	>=kde-base/drkonqi-${PV}:${SLOT}
	>=kde-base/kappfinder-${PV}:${SLOT}
	>=kde-base/kcheckpass-${PV}:${SLOT}
	>=kde-base/kcminit-${PV}:${SLOT}
	>=kde-base/kcmshell-${PV}:${SLOT}
	>=kde-base/kcontrol-${PV}:${SLOT}
	>=kde-base/kde-menu-${PV}:${SLOT}
	>=kde-base/kde-menu-icons-${PV}:${SLOT}
	>=kde-base/kde-wallpapers-${PV}:${SLOT}
	>=kde-base/kdebase-cursors-${PV}:${SLOT}
	>=kde-base/kdebase-data-${PV}:${SLOT}
	>=kde-base/kdebase-desktoptheme-${PV}:${SLOT}
	>=kde-base/kdebase-kioslaves-${PV}:${SLOT}
	>=kde-base/kdebase-startkde-${PV}:${SLOT}
	>=kde-base/kdebugdialog-${PV}:${SLOT}
	>=kde-base/kdedglobalaccel-${PV}:${SLOT}
	>=kde-base/kdepasswd-${PV}:${SLOT}
	>=kde-base/kdesu-${PV}:${SLOT}
	>=kde-base/kdialog-${PV}:${SLOT}
	>=kde-base/kdm-${PV}:${SLOT}
	>=kde-base/keditbookmarks-${PV}:${SLOT}
	>=kde-base/kephal-${PV}:${SLOT}
	>=kde-base/kfile-${PV}:${SLOT}
	>=kde-base/kfind-${PV}:${SLOT}
	>=kde-base/khelpcenter-${PV}:${SLOT}
	>=kde-base/khotkeys-${PV}:${SLOT}
	>=kde-base/kiconfinder-${PV}:${SLOT}
	>=kde-base/kinfocenter-${PV}:${SLOT}
	>=kde-base/kioclient-${PV}:${SLOT}
	>=kde-base/klipper-${PV}:${SLOT}
	>=kde-base/kmenuedit-${PV}:${SLOT}
	>=kde-base/kmimetypefinder-${PV}:${SLOT}
	>=kde-base/knetattach-${PV}:${SLOT}
	>=kde-base/knewstuff-${PV}:${SLOT}
	>=kde-base/konqueror-${PV}:${SLOT}
	>=kde-base/konsole-${PV}:${SLOT}
	>=kde-base/kpasswdserver-${PV}:${SLOT}
	>=kde-base/kquitapp-${PV}:${SLOT}
	>=kde-base/kscreensaver-${PV}:${SLOT}
	>=kde-base/ksmserver-${PV}:${SLOT}
	>=kde-base/ksplash-${PV}:${SLOT}
	>=kde-base/kstart-${PV}:${SLOT}
	>=kde-base/kstartupconfig-${PV}:${SLOT}
	>=kde-base/kstyles-${PV}:${SLOT}
	>=kde-base/ksysguard-${PV}:${SLOT}
	>=kde-base/ksystraycmd-${PV}:${SLOT}
	>=kde-base/ktimezoned-${PV}:${SLOT}
	>=kde-base/ktraderclient-${PV}:${SLOT}
	>=kde-base/kuiserver-${PV}:${SLOT}
	>=kde-base/kurifilter-plugins-${PV}:${SLOT}
	>=kde-base/kwalletd-${PV}:${SLOT}
	>=kde-base/kwin-${PV}:${SLOT}
	>=kde-base/kwrite-${PV}:${SLOT}
	>=kde-base/kwrited-${PV}:${SLOT}
	>=kde-base/libkonq-${PV}:${SLOT}
	>=kde-base/libkworkspace-${PV}:${SLOT}
	>=kde-base/libplasmaclock-${PV}:${SLOT}
	>=kde-base/libtaskmanager-${PV}:${SLOT}
	>=kde-base/nsplugins-${PV}:${SLOT}
	>=kde-base/phonon-kde-${PV}:${SLOT}
	>=kde-base/plasma-apps-${PV}:${SLOT}
	>=kde-base/plasma-workspace-${PV}:${SLOT}
	>=kde-base/powerdevil-${PV}:${SLOT}
	>=kde-base/renamedlg-plugins-${PV}:${SLOT}
	>=kde-base/solid-${PV}:${SLOT}
	>=kde-base/solid-hardware-${PV}:${SLOT}
	>=kde-base/soliduiserver-${PV}:${SLOT}
	>=kde-base/systemsettings-${PV}:${SLOT}
	semantic-desktop? ( >=kde-base/nepomuk-${PV}:${SLOT} )
"
