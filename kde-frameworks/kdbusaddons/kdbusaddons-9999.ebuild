# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FRAMEWORKS_TYPE="tier1"
VIRTUALDBUS_TEST="true"
inherit kde-frameworks

DESCRIPTION="Tools to register applications on the session bus"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-qt/qtdbus:5
"
DEPEND="${RDEPEND}"
