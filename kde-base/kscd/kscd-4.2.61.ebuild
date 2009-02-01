# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="KDE CD player"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

DEPEND=">=kde-base/libkcddb-${PV}:${SLOT}
	>=kde-base/libkcompactdisc-${PV}:${SLOT}
	media-libs/musicbrainz:1"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libkcompactdisc/"
