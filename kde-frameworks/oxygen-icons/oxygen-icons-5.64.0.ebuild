# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_ORG_NAME="oxygen-icons5"
inherit cmake-utils kde.org

DESCRIPTION="Oxygen SVG icon theme"
LICENSE="LGPL-3"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
IUSE="test"

BDEPEND="
	dev-qt/qtcore:5
	kde-frameworks/extra-cmake-modules:5
	test? ( app-misc/fdupes )
"
DEPEND="test? ( dev-qt/qttest:5 )"
