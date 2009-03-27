# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/lskat/lskat-4.2.1.ebuild,v 1.1 2009/03/04 22:46:53 alexxy Exp $

EAPI="2"

KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="Skat game for KDE"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

KMLOADLIBS="libkdegames"
