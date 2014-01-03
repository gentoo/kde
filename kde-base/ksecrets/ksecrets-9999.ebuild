# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="KDE secrets service"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	app-crypt/qca:2
	net-libs/libssh2
"
DEPEND="${RDEPEND}
	$(add_kdebase_dep libkworkspace)
"

RESTRICT=test
# no bug yet but tests fail
