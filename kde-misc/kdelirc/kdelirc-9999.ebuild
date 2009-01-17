# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="playground/utils"
inherit kde4-base

DESCRIPTION="KDE frontend for the Linux Infrared Remote Control system"
HOMEPAGE="http://kde.org/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="live"
IUSE="debug"

RDEPEND="${DEPEND}
	app-misc/lirc
"
