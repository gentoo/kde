# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-apps"
KMMODULE="lib/konq"
CPPUNIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="The embeddable part of konqueror"
KEYWORDS=""
IUSE="debug"
RESTRICT="test"

KMSAVELIBS="true"

PATCHES=( "${FILESDIR}/fix_includes_install.patch" )
