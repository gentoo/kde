# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="KDE CD player"
KEYWORDS=""
IUSE="debug doc"

DEPEND="
	>=kde-base/libkcddb-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libkcompactdisc-${PV}:${SLOT}[kdeprefix=]
	media-libs/musicbrainz:1
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	libkcompactdisc/
"
