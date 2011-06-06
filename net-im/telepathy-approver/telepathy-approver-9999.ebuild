# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="This notifies you when an incoming message arrives and hangs in the system tray until you're ready to start a chat."
HOMEPAGE=""

LICENSE="GPL-3"
KEYWORDS="~amd64"
SLOT="0"
IUSE="debug"

DEPEND="
	>=net-libs/telepathy-qt4-0.5.6
"
RDEPEND="${DEPEND}"
