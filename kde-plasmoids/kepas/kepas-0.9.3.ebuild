# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="KDE Easy Publish and Share."
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=73968"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="live"
IUSE="oscar zeroconf"

DEPEND="zeroconf? ( kde-base/kdnssd:${SLOT} )
	oscar? ( kde-base/kopete:${SLOT}[oscar] )"
