# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="1"

KMNAME=kdebase
KMMODULE=apps/${PN}
inherit kde4svn-meta

DESCRIPTION="KDE file finder utility"
KEYWORDS=""
IUSE="debug htmlhandbook"

DEPEND=">=kde-base/libkonq-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMEXTRA="apps/doc/${PN}"
KMLOADLIBS="libkonq"
