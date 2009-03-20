# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils subversion

DESCRIPTION="Decibel is a realtime communications framework"
HOMEPAGE="http://decibel.kde.org/"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/kdesupport/decibel"

LICENSE="LGPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug"

RESTRICT="test"

DEPEND="
	net-voip/tapioca-qt
"
RDEPEND="${DEPEND}"

src_prepare() {
	append-ldflags -Wl,--no-as-needed
}
