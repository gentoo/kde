# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_TEST="true"
inherit kde5

if [[ ${KDE_BUILD_TYPE} != live ]]; then
	KEYWORDS="~amd64 ~x86"
	SRC_URI="mirror://kde/unstable/plasma/${PV}/src/${P}.tar.xz"
else
	KEYWORDS=" ~amd64"
fi

DESCRIPTION="NetworkManager bindings for Qt"
HOMEPAGE="https://projects.kde.org/projects/extragear/libs/libnm-qt"

LICENSE="LGPL-2"
# maybe remove SLOT when it becomes official KDE Framework
SLOT="0"
IUSE="teamd"

RDEPEND="
	dev-qt/qtdbus:5
	dev-qt/qtnetwork:5
	|| (
		>=net-misc/networkmanager-0.9.10.0[consolekit,teamd=]
		>=net-misc/networkmanager-0.9.10.0[systemd,teamd=]
	)
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"
