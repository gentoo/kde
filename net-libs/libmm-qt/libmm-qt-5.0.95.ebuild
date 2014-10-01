# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

if [[ ${KDE_BUILD_TYPE} != live ]]; then
	KEYWORDS="~amd64 ~x86"
	SRC_URI="mirror://kde/unstable/plasma/${PV}/${P}.tar.xz"
else
	KEYWORDS=""
fi

DESCRIPTION="Modemmanager bindings for Qt"
HOMEPAGE="https://projects.kde.org/projects/extragear/libs/libmm-qt"

LICENSE="LGPL-2"
# maybe remove SLOT when it becomes a official KDE Framework
SLOT="0"
IUSE=""

RDEPEND="
	dev-qt/qtdbus:5
	dev-qt/qtxml:5
	net-misc/mobile-broadband-provider-info
	>=net-misc/networkmanager-0.9.8[modemmanager]
"
DEPEND="${RDEPEND}"
