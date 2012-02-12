# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="Qt4 bindings for the Telepathy logger"
HOMEPAGE="https://projects.kde.org/projects/playground/network/telepathy/telepathy-logger-qt"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="
	media-sound/qt-gstreamer
	>=net-im/telepathy-logger-0.2.12-r1
"
RDEPEND="${DEPEND}"
