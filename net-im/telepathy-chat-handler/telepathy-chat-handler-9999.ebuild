# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="This application provides a text chat window."
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"
IUSE="debug"

DEPEND="
	>=net-libs/telepathy-qt4-0.7.0
"
RDEPEND="${DEPEND}"
