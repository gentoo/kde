# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git kde4-base

DESCRIPTION="KDE4 IRC development library."
HOMEPAGE="http://www.kde.org/"
EGIT_REPO_URI="git://gitorious.org/aki/akiirc.git"

LICENSE="LGPL-2.1"
KEYWORDS=""
SLOT="4"
IUSE="debug"

RDEPEND="
	>=x11-libs/qt-core-${QT_MINIMAL}:4[ssl]
"
DEPEND="${RDEPEND}"

src_unpack() {
	git_src_unpack
}
