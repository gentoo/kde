# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DECLARATIVE_REQUIRED="always"
inherit kde4-base

DESCRIPTION="KDE Plasma applet for NetworkManager"
HOMEPAGE="https://projects.kde.org/projects/playground/network/plasma-nm"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS=""
IUSE="debug"

DEPEND="
	net-libs/libmm-qt
	net-libs/libnm-qt
	>=net-misc/networkmanager-0.9.8.0
"
RDEPEND="${DEPEND}"
