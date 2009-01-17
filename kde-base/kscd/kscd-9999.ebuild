# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="KDE CD player"
KEYWORDS=""
IUSE="debug htmlhandbook"

DEPEND=">=kde-base/libkcddb-${PV}:${SLOT}
	>=kde-base/libkcompactdisc-${PV}:${SLOT}
	media-libs/musicbrainz:1"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libkcompactdisc/"
