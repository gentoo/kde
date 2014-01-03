# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kde-workspace"
inherit kde4-meta

DESCRIPTION="Ksystraycmd embeds applications given as argument into the system tray."
KEYWORDS=""
IUSE="debug"

DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND}"
