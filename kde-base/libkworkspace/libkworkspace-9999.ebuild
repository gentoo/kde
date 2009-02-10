# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-workspace"
KMMODULE="libs/kworkspace"
inherit kde4-meta

DESCRIPTION="A library for KDE desktop applications"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	!kdeprefix? ( !<kde-base/libkworkspace-${PV} )
	kdeprefix? ( !<kde-base/libkworkspace-${PV}:${SLOT} )
"

KMEXTRACTONLY="
	ksmserver/org.kde.KSMServerInterface.xml
	kwin/org.kde.KWin.xml
"

KMSAVELIBS="true"
