# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE frontend for the Linux Infrared Remote Control system"
HOMEPAGE="http://www.kde.org/applications/utilities/kremotecontrol
http://utils.kde.org/projects/kremotecontrol"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	app-misc/lirc
"
