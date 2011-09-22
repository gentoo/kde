# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE Telepathy protocols plugins for account management"
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"
KEYWORDS=""

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="debug irc purple jabber msn zeroconf"

DEPEND="
	net-im/telepathy-accounts-kcm
	irc? ( net-irc/telepathy-idle )
	jabber? ( net-voip/telepathy-gabble )
	msn? ( net-voip/telepathy-butterfly )
	purple? ( net-voip/telepathy-haze )
	zeroconf? ( net-voip/telepathy-salut )
"
RDEPEND="${DEPEND}"
