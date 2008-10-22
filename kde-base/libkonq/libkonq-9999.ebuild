# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="1"

KMNAME=kdebase
KMMODULE=apps/lib/konq
CPPUNIT_REQUIRED="optional"
inherit kde4svn-meta

DESCRIPTION="The embeddable part of konqueror"
KEYWORDS=""
IUSE="debug"
RESTRICT="test"
# PATCHES="${FILESDIR}/fix_includes_install.patch"
KMSAVELIBS="true"
src_compile() {
	epatch "${FILESDIR}"/fix_includes_install.patch
	kde4overlay-meta_src_compile
}
