# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils subversion

DESCRIPTION="Decibel is a realtime communications framework"
HOMEPAGE="http://decibel.kde.org/"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/kdesupport/decibel"

SLOT="0"
KEYWORDS=""
LICENSE="LGPL-2"
IUSE="debug"

RESTRICT="test"

DEPEND="
	net-voip/tapioca-qt"

src_prepare() {
	append-ldflags -Wl,--no-as-needed
}
