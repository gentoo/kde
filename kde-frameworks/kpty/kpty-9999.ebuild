# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FRAMEWORKS_TYPE="tier3"
FRAMEWORKS_DOXYGEN="true"
inherit kde-frameworks

DESCRIPTION="Framework for pseudo terminal devices and running child processes"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	sys-libs/libutempter
"
RDEPEND="${DEPEND}"
