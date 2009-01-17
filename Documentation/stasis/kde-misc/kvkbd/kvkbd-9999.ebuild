# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

SLOT="kde-svn"
NEED_KDE=":${SLOT}"
KMNAME="playground/utils"
inherit kde4svn-meta

DESCRIPTION="kde on-screen keyboard"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"
KEYWORDS=""
IUSE="debug"

PREFIX="${KDEDIR}"

RDEPEND=""
DEPEND="${RDEPEND}"
