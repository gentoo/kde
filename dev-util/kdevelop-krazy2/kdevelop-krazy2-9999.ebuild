# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDEBASE="kdevelop"
KMNAME="kdev-krazy2"
VIRTUALX_REQUIRED="test"
inherit kde4-base

DESCRIPTION="Plugin for KDevelop to perform Krazy2 analysis"
LICENSE="GPL-2+"
KEYWORDS=""
IUSE="debug"

RESTRICT="test"

DEPEND="dev-util/kdevplatform:4"

RDEPEND="${DEPEND}
	dev-util/kdevelop:4
"
