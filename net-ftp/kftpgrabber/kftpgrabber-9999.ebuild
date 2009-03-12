# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/network"
inherit kde4-base

DESCRIPTION="FTP client for K Desktop Environment"
HOMEPAGE="http://www.kftp.org"

LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug"

DEPEND="
	net-libs/libssh2
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-add-LibSSH2.cmake.patch" )
