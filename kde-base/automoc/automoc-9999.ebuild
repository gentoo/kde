# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils subversion

DESCRIPTION="KDE Meta Object Compiler"
HOMEPAGE="http://www.kde.org"
SRC_URI=""
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/kdesupport/automoc"

LICENSE="as-is"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="x11-libs/qt-core:4"
RDEPEND="${RDEPEND}"
