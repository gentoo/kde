# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="KDE accounts providers"
HOMEPAGE="https://community.kde.org/KTp"
LICENSE="LGPL-2.1"
IUSE=""

DEPEND=""
RDEPEND="
	net-im/telepathy-connection-managers[xmpp]
	net-libs/signon-ui
	net-libs/signon-oauth2
"
