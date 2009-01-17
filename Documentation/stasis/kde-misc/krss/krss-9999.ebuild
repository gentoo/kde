# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
HOMEPAGE="http://www.kde.org"
KMNAME="playground/pim"
SLOT="kde-svn"
NEED_KDE=":${SLOT}"
inherit kde4svn-meta

PREFIX="${KDEDIR}"
DESCRIPTION="KDE rss reader"
LICENSE="GPL-2"
IUSE="debug"
KEYWORDS=""
