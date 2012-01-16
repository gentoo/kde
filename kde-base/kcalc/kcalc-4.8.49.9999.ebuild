# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_HANDBOOK="optional"
CPPUNIT_REQUIRED="optional"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE calculator"
KEYWORDS=""
IUSE="debug"

DEPEND="
	dev-libs/gmp
"
RDEPEND="${DEPEND}"

RESTRICT="test"
# bug 393093

PATCHES=(
	"${FILESDIR}"/${PN}-4.3.2-solaris-knumber_priv.patch
)

src_test() {
	LANG=C kde4-base_src_test
}
