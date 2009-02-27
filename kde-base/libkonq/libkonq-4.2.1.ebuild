# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkonq/libkonq-4.2.0.ebuild,v 1.2 2009/02/01 08:24:14 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdebase"
KMMODULE="apps/lib/konq"
CPPUNIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="The embeddable part of konqueror"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"
RESTRICT="test"
PATCHES=("${FILESDIR}/fix_includes_install.patch")
KMSAVELIBS="true"
