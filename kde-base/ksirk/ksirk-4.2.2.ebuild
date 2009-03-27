# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksirk/ksirk-4.2.1.ebuild,v 1.2 2009/03/08 13:59:36 scarabeus Exp $

EAPI="2"

KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="KDE: Ksirk is a KDE port of the board game risk"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	app-crypt/qca:2
"
RDEPEND="${DEPEND}"
