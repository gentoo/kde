# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde-frameworks

DESCRIPTION="Framework providing access to Open Collaboration Services"
LICENSE="LGPL-2.1+"
KEYWORDS=" ~amd64"
IUSE="debug test"

RDEPEND="
	dev-qt/qtnetwork:5
"
DEPEND="${RDEPEND}"
