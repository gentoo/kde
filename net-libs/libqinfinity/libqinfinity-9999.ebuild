# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
MY_P="${PN}-v${PV}"

inherit cmake-utils git-2

DESCRIPTION="Qt-style interface for libinfinity"
HOMEPAGE="https://projects.kde.org/projects/playground/libs/libqinfinity"
EGIT_REPO_URI="git://anongit.kde.org/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	dev-libs/glib:2
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	net-libs/libinfinity
"
DEPEND="${RDEPEND}
	app-arch/xz-utils
"

S=${WORKDIR}/${MY_P}
