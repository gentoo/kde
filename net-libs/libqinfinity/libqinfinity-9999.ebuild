# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils git

DESCRIPTION="QT-style Interface for libinfinity"
HOMEPAGE="http://kobby.greghaynes.net/wiki/libqinfinity"
EGIT_REPO_URI="git://gitorious.com/${PN}/${PN}.git"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug"

DEPEND="
	>=net-libs/libinfinity-0.4.1
"
RDEPEND="${DEPEND}"
