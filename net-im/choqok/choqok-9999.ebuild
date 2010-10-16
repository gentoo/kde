# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/choqok/choqok-0.9.90-r1.ebuild,v 1.1 2010/09/07 01:22:48 tampakrap Exp $

EAPI=3

KMNAME="extragear/network"

if [[ ${PV} != *9999* ]]; then
	KDE_LINGUAS="bg cs da de el en_GB eo es et fi fr ga gl hr hu is ja km lt ms nb
	nds nl pa pl pt pt_BR ro ru sk sv tr uk zh_CN zh_TW"
	SRC_URI="http://d10xg45o6p6dbl.cloudfront.net/projects/c/choqok/${P}.tar.bz2"
fi

inherit kde4-base

DESCRIPTION="A Free/Open Source micro-blogging client for KDE"
HOMEPAGE="http://choqok.gnufolks.org/"

LICENSE="GPL-3"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="dev-libs/qjson
		>=dev-libs/qoauth-1.0.1"
RDEPEND="${DEPEND}"
