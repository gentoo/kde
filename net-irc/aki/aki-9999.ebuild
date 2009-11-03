# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git kde4-base

DESCRIPTION="Extensive IRC Client for KDE4"
HOMEPAGE="http://www.kde.org/"
EGIT_REPO_URI="git://gitorious.org/aki/aki.git"

LICENSE="LGPL-2.1"
KEYWORDS=""
SLOT="4"
IUSE="debug"

RDEPEND="
	net-irc/akiirc:4
	>=x11-libs/qt-core-${QT_MINIMAL}:4[ssl]
"
DEPEND="${RDEPEND}"

src_unpack() {
	git_src_unpack
}
