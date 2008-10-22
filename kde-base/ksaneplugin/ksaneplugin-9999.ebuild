# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME="kdegraphics"
NEED_KDE="svn"
SLOT="kde-svn"

inherit kde4svn-meta

DESCRIPTION="SANE Plugin for KDE"
HOMEPAGE="http://www.kipi-plugins.org"

LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

DEPEND="kde-base/libksane:${SLOT}"
RDEPEND="${DEPEND}"
