# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kigo/kigo-4.4.2.ebuild,v 1.1 2010/03/30 21:06:34 spatz Exp $

EAPI="3"

KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="KDE Go game"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

RDEPEND="games-board/gnugo"
