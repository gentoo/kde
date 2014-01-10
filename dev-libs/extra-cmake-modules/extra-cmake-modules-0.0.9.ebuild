# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="Extra modules and scripts for CMake"
HOMEPAGE="https://projects.kde.org/projects/kdesupport/extra-cmake-modules"
SRC_URI="mirror://kde/unstable/frameworks/4.95.0/${P}.tar.xz"

LICENSE="BSD"
SLOT=0
KEYWORDS="~amd64"

DEPEND="
	app-arch/xz-utils
	>=dev-util/cmake-2.8.12
"
