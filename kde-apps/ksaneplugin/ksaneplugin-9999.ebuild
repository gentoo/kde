# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="SANE Plugin for KDE"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdeapps_dep libksane)
"
RDEPEND="${DEPEND}"
