# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/network"
inherit kde4-meta

DESCRIPTION="FTP client for K Desktop Environment"
HOMEPAGE="http://www.kftp.org"

LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
SLOT="live"
IUSE="debug"

DEPEND="
	net-libs/libssh2
"
RDEPEND="${DEPEND}"
