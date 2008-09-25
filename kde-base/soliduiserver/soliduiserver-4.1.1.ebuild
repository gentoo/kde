# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2_pre3"

KMNAME=kdebase-runtime
inherit kde4-meta

DESCRIPTION="KDE4: Soliduiserver"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=kde-base/solid-${PV}:${SLOT}"
RDEPEND="${DEPEND}"
