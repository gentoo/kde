# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="playground/network"
inherit kde4-base

DESCRIPTION="Extensive IRC Client for KDE4"
HOMEPAGE="http://www.kde.org/"

LICENSE="LGPL-2.1"
KEYWORDS=""
SLOT="4"
IUSE="debug"

RDEPEND="
	>=x11-libs/qt-core-${QT_DEPEND}:4[ssl]
	net-irc/akiirc:4
"

DEPEND="${RDEPEND}"
