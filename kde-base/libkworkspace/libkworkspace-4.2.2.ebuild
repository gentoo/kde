# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkworkspace/libkworkspace-4.2.1.ebuild,v 1.4 2009/03/15 14:40:05 scarabeus Exp $

EAPI="2"

KMNAME="kdebase-workspace"
KMMODULE="libs/kworkspace"
inherit kde4-meta

DESCRIPTION="A library for KDE desktop applications"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

RDEPEND="
	!kdeprefix? ( !<kde-base/libkworkspace-${PV}[-kdeprefix] )
	kdeprefix? ( !<kde-base/libkworkspace-${PV}:${SLOT} )
"

KMEXTRACTONLY="
	ksmserver/org.kde.KSMServerInterface.xml
	kwin/org.kde.KWin.xml
"

KMSAVELIBS="true"
