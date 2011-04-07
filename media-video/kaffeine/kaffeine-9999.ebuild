# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="A media player for KDE with digital TV support"
HOMEPAGE="http://kaffeine.kde.org/"

LICENSE="GPL-2 FDL-1.2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="
	media-libs/xine-lib
	x11-libs/libXScrnSaver
	x11-libs/qt-sql:4[sqlite]
	$(add_kdebase_dep solid)
"
RDEPEND="${DEPEND}"
