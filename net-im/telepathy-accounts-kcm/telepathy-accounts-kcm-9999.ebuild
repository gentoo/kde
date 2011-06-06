# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE UI for account management"
HOMEPAGE=""

LICENSE="GPL-3"
KEYWORDS="~amd64"
SLOT="0"
IUSE="debug"

DEPEND="
	>=net-libs/telepathy-glib-0.14
	>=net-libs/telepathy-qt4-0.5.10
	>=net-im/telepathy-mission-control-5.5.0
"
RDEPEND="${DEPEND}"
