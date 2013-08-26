# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DECLARATIVE_REQUIRED="always"
VIRTUALX_REQUIRED="test"
inherit kde4-base

DESCRIPTION="Collaborative text editor via kde-telepathy"
HOMEPAGE="https://projects.kde.org/projects/playground/network/kte-collaborative"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	dev-libs/glib:2
	net-im/ktp-common-internals
	net-libs/libinfinity[server]
	net-libs/libqinfinity
	>=net-libs/telepathy-qt-0.8.9
"
DEPEND="${RDEPEND}
	app-arch/xz-utils
"

# hangs
RESTRICT="test"
