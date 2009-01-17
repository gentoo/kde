# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="playground/base/plasma/applets"
KMMODULE="networkmanager"
inherit kde4-base

DESCRIPTION="A NetworkManager applet for kde"
HOMEPAGE="http://kde.org/"
LICENSE="GPL-2 LGPL-2"

KEYWORDS=""
IUSE=""
SLOT="live"

DEPEND=">=net-misc/networkmanager-0.7"
