# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit cmake-utils

DESCRIPTION="Cache/proxy system for the SSDP part of UPnP"
HOMEPAGE="http://frinring.wordpress.com/2010/08/09/cagibi-0-1-1-released-network-kio-slave-freezes-kded-in-4-5-0/"
SRC_URI="mirror://kde/stable/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

RDEPEND="x11-libs/qt-dbus"
DEPEND="dev-util/automoc
	${RDEPEND}"
