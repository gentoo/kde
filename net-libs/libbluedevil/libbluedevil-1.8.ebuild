# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit kde4-base

MY_P=${PN}-v${PV}-1
DESCRIPTION="A Qt wrapper for bluez used in the KDE bluetooth stack"
HOMEPAGE="http://gitorious.org/libbluedevil"
SRC_URI="http://media.ereslibre.es/2010/11/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	net-wireless/bluez
"

S=${WORKDIR}/${MY_P}
