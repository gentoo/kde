# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2_pre1"

NEED_KDE="4.1"
inherit kde4-base

DESCRIPTION="Bluetooth Framework for KDE 4."
HOMEPAGE="http://bluetooth.kmobiletools.org/"
SRC_URI="mirror://sourceforge/kde-bluetooth/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4.1"
KEYWORDS="~x86 ~amd64"
IUSE=""

COMMONDEPEND="kde-base/solid:${SLOT}[bluetooth]"
DEPEND="${COMMONDEPEND}"
RDEPEND="${DEPEND}"
