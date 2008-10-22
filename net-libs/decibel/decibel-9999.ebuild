# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="none"

inherit eutils flag-o-matic kde4svn
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/kdesupport/decibel"

DESCRIPTION="Decibel is a realtime communications framework"
HOMEPAGE="http://decibel.kde.org/"

SLOT="0"
KEYWORDS=""
LICENSE="LGPL-2"
IUSE=""

RESTRICT="test"

DEPEND="
	net-voip/tapioca-qt"
#	doc? ( app-doc/doxygen )"
# FIXME: handle doxygen documentation.

src_compile() {
	append-ldflags -Wl,--no-as-needed
	kde4overlay-base_src_compile
}
