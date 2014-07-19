# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_TEST="true"
KDE_DOXYGEN="true"
inherit kde5

if [[ ${KDE_BUILD_TYPE} != live ]]; then
	KEYWORDS="~amd64 ~x86"
	SRC_URI="mirror://kde/stable/plasma/5.0.0/${P}.tar.xz"
else
	KEYWORDS=""
fi

DESCRIPTION="NetworkManager bindings for Qt"
HOMEPAGE="https://projects.kde.org/projects/extragear/libs/libnm-qt"

LICENSE="LGPL-2"
# maybe remove SLOT when it becomes official KDE Framework
SLOT="0"
IUSE=""

RDEPEND="
	dev-qt/qtdbus:5
	dev-qt/qtnetwork:5
	>=net-misc/networkmanager-0.9.8.4
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(	-DBUILD_EXAMPLES=FALSE )

	kde5_src_configure
}
