# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdegames/libkdegames-4.2.1.ebuild,v 1.2 2009/03/08 14:12:31 scarabeus Exp $

EAPI="2"

KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="Base library common to many KDE games."
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	>=dev-games/ggz-client-libs-0.0.14
"
RDEPEND="${DEPEND}"

KMSAVELIBS="true"
