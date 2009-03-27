# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkonq/libkonq-4.2.1.ebuild,v 1.4 2009/03/15 14:39:41 scarabeus Exp $

EAPI="2"

KMNAME="kdebase-apps"
KMMODULE="lib/konq"
CPPUNIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="The embeddable part of konqueror"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"
RESTRICT="test"

KMSAVELIBS="true"

PATCHES=( "${FILESDIR}/fix_includes_install.patch" )
