# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

if [[ ${PV} == *9999* ]] ; then
	KMNAME="extragear/network"
else
	# upstream likes to skip that _ in beta releases
	KTORRENT_VERSION="4.0rc1"
	MY_PV="${PV/_/}"
	MY_P="${PN}-${MY_PV}"

	KDE_LINGUAS="ar be bg ca cs da de el en_GB es et eu fr ga gl hi hne hr hu is it
		ja km lt lv mai ms nb nds nl nn oc pl pt pt_BR ro ru se sk sl sr sv
		tr uk zh_CN zh_TW"
	SRC_URI="http://ktorrent.org/downloads/${KTORRENT_VERSION}/${MY_P}.tar.bz2"
	S="${WORKDIR}"/"${MY_P}"
fi

inherit kde4-base

DESCRIPTION="A BitTorrent program for KDE."
HOMEPAGE="http://ktorrent.org/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

COMMONDEPEND="
	app-crypt/qca:2
	dev-libs/gmp
"
DEPEND="${COMMONDEPEND}
	dev-libs/boost
	sys-devel/gettext
"
RDEPEND="${COMMONDEPEND}"