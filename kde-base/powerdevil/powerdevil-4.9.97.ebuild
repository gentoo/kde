# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kde-workspace"
inherit kde4-meta

DESCRIPTION="PowerDevil is an utility for KDE4 for Laptop Powermanagement."
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +pm-utils"

DEPEND="
	$(add_kdebase_dep kactivities)
	$(add_kdebase_dep libkworkspace)
	$(add_kdebase_dep solid)
"
RDEPEND="${DEPEND}
	pm-utils? ( sys-power/pm-utils )
"

KMEXTRACTONLY="
	krunner/
	ksmserver/org.kde.KSMServerInterface.xml
	ksmserver/screenlocker/dbus/org.freedesktop.ScreenSaver.xml
"
