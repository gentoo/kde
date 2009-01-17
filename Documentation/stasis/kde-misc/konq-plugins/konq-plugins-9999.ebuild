# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME="extragear/base"

inherit kde4svn-meta

MY_PV="${PV%_pre*}"
PREFIX="${KDEDIR}"
SLOT="kde-svn"

DESCRIPTION="Konqueror plugins."
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2 LGPL-2"

KEYWORDS=""
IUSE=""

DEPEND="
	kde-base/konqueror:${SLOT}
	kde-base/libkonq:${SLOT}"
RDEPEND="${DEPEND}"
