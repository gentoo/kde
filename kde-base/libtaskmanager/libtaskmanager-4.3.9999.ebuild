# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-workspace"
KMMODULE="libs/taskmanager"
inherit kde4-meta

DESCRIPTION="A library that provides basic taskmanager functionality"
KEYWORDS=""
IUSE="debug"

DEPEND="
	>=kde-base/kephal-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}"

KMSAVELIBS="true"
