# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit kde4-base

DESCRIPTION="Supporting library for new intelligent KDE screen management"
HOMEPAGE="https://projects.kde.org/projects/playground/libs/libkscreen"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=dev-libs/qjson-0.8"
RDEPEND="${DEPEND}"
