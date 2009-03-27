# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kscd/kscd-4.2.1.ebuild,v 1.2 2009/03/08 13:58:20 scarabeus Exp $

EAPI="2"

KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="KDE CD player"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	>=kde-base/libkcddb-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libkcompactdisc-${PV}:${SLOT}[kdeprefix=]
	media-libs/musicbrainz:1
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	libkcompactdisc/
"
