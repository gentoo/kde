# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_MINIMAL="4.1"
KMNAME="extragear/utils"
inherit kde4-base

DESCRIPTION="A quake-style terminal emulator based on KDE konsole technology"
HOMEPAGE="http://yakuake.kde.org/"
LICENSE="GPL-2 LGPL-2"

KEYWORDS=""
IUSE=""
SLOT="live"

DEPEND=">=kde-base/konsole-${KDE_MINIMAL}"
