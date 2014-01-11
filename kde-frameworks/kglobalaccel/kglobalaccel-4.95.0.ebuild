# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde-frameworks

DESCRIPTION="Framework to handle global shortcuts"
KEYWORDS="~amd64"
LICENSE="LGPL-2+"
IUSE=""

DEPEND="
	dev-qt/qtdbus:5
	dev-qt/qtwidgets:5
"
RDEPEND="${DEPEND}"
