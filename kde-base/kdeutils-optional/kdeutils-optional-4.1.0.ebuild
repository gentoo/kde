# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit kde4-functions

DESCRIPTION="KDE utilities - optional packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.1"
KEYWORDS="~amd64"
IUSE="floppy"

RDEPEND="floppy? ( >=kde-base/kfloppy-${PV}:${SLOT} )"
