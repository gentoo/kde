# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="KDE: Ksirk is a KDE port of the board game risk"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

DEPEND="
	app-crypt/qca:2
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-4.2.1-freebsd-darwin.patch"
)
