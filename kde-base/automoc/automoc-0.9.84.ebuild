# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils

DESCRIPTION="KDE Meta Object Compiler"
HOMEPAGE="http://www.kde.org"
SRC_URI="mirror://kde/unstable/${PN}4/${PV}/${PN}4-${PV}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-core:4"
RDEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}4-${PV}"
