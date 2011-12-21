# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE secrets service"
KEYWORDS=""
IUSE="debug"

DEPEND="
	app-crypt/qca:2
	net-libs/libssh2
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-fix-build.patch"
)
