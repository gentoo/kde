# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_LINGUAS="cs de el et ga gl km lt nds nl pt pt_BR ro ru sv tr uk zh_CN"
inherit kde4-base

DESCRIPTION="A Free/Open Source micro-blogging client for K Desktop Environment."
HOMEPAGE="http://choqok.gnufolks.org/"
SRC_URI="http://mirror.umoss.org/download.ospdev.net/${PN}/${PN}/${PV}Norooz/${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"
