# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="File manager plugin to launch a file transfer job with a specified contact."
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"

LICENSE="LGPL-2.1"
KEYWORDS=""
SLOT="0"
IUSE="debug"

DEPEND="
	>=net-libs/telepathy-qt4-0.7.1
"
RDEPEND="${DEPEND}"
