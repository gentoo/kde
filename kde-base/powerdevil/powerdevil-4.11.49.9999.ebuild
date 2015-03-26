# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kde-workspace"
inherit kde4-meta

DESCRIPTION="PowerDevil is an utility for KDE4 for Laptop Powermanagement"
HOMEPAGE="http://solid.kde.org"
KEYWORDS=""
IUSE="debug +pm-utils"

DEPEND="
	$(add_kdebase_dep kactivities)
	$(add_kdebase_dep libkworkspace)
	!aqua? (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXrandr
	)
"
RDEPEND="${DEPEND}
	pm-utils? ( sys-power/pm-utils )
"

KMEXTRACTONLY="
	krunner/
	ksmserver/org.kde.KSMServerInterface.xml
	ksmserver/screenlocker/dbus/org.freedesktop.ScreenSaver.xml
"
