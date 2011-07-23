# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE Telepathy protocols plugins for account management"
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"
IUSE="debug purple jabber msn"

DEPEND="
	net-im/telepathy-accounts-kcm
	purple? ( net-voip/telepathy-haze )
	jabber? ( net-voip/telepathy-gabble )
	msn? ( net-voip/telepathy-butterfly )
"
RDEPEND="${DEPEND}"
