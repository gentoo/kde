# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

ESCM_REPONAME="bluedevil"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="Bluetooth stack for KDE"
HOMEPAGE="http://gitorious.org/bluedevil"

LICENSE="GPL-3"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="
	net-libs/libbluedevil
	x11-misc/shared-mime-info
"
RDEPEND="${DEPEND}
	!net-wireless/kbluetooth
	app-mobilephone/obexd[-server]
	app-mobilephone/obex-data-server
"
