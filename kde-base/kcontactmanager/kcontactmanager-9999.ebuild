# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KDE Contact Manager"
KEYWORDS=""
IUSE="debug"

DEPEND="
	>=kde-base/kontactinterfaces-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libkdepim-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}
	app-crypt/gnupg
"

KMLOADLIBS="libkdepim"

KMEXTRACTONLY="
	kontactinterfaces/
"
