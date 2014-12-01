# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="KDE KAccount providers"
HOMEPAGE="https://community.kde.org/KTp"

LICENSE="LGPL-2.1"
SLOT="5"
IUSE="telepathy"

DEPEND=""
RDEPEND="
	telepathy? ( net-im/telepathy-connection-managers[jabber] )
	net-libs/signon-ui
	net-libs/signon-oauth2
"
