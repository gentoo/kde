# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils git-r3

DESCRIPTION="Extra modules and scripts for CMake"
HOMEPAGE="https://projects.kde.org/projects/kdesupport/extra-cmake-modules"
EGIT_REPO_URI=( "git://anongit.kde.org/${PN}" )

LICENSE="BSD"
SLOT=0
KEYWORDS=""

DEPEND="
	>=dev-util/cmake-2.8.12
"
