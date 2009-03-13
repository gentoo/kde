# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/sysadmin"
inherit kde4-base

DESCRIPTION="KDE4 partition manager frontend."
HOMEPAGE="http://partitionman.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug"

DEPEND="
	sys-apps/parted
	sys-libs/e2fsprogs-libs
"
RDEPEND="${DEPEND}"
