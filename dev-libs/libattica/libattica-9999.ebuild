# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KEYWORDS=""

DESCRIPTION="A library providing access to Open Collaboration Services (dummy package)"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
IUSE="debug +qt4 qt5 test"

RDEPEND="kde-frameworks/libattica[debug?,qt4?,qt5?,test?]"
DEPEND="${RDEPEND}"
