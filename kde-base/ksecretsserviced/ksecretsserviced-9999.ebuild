# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="KDE secrets service daemon"
KEYWORDS=""
IUSE="debug"

DEPEND="
	app-crypt/qca:2
"
RDEPEND="${DEPEND}"
