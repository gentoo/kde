# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

SLOT="kde-svn"
NEED_KDE=":${SLOT}"
KMNAME="extragear/graphics/"
inherit kde4svn-meta

DESCRIPTION="KDE Screen Grabbing Utility"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
IUSE="debug"

PREFIX="${KDEDIR}"

RDEPEND=""
DEPEND="${RDEPEND}
	sys-devel/gettext
	x11-proto/xextproto"
