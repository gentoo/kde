# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE account management UI"
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"

LICENSE="LGPL-2.1"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="
	>=net-libs/telepathy-glib-0.14
	>=net-libs/telepathy-qt4-0.7.1
	>=net-im/telepathy-mission-control-5.7.9
"
RDEPEND="${DEPEND}
	>=net-im/telepathy-contact-list-${PV}
"
