# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

HOMEPAGE="http://decibel.kde.org"
KMNAME="playground/network/${PN}"
SLOT="kde-svn"
NEED_KDE=":kde-svn"
inherit kde4svn
PREFIX="${KDEDIR}"

DESCRIPTION="Decibel KDE plugins"
LICENSE="LGPL-2.1"
IUSE="debug"
KEYWORDS=""
DEPEND="net-libs/decibel"

src_unpack() {
	kde4svn_src_unpack
}
