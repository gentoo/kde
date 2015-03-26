# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kde-workspace"
KMMODULE="libs/kdm"
inherit kde4-meta

DESCRIPTION="Conversation widgets for KDM greeter"
KEYWORDS=""
IUSE="debug"

DEPEND="
	!<kde-base/kdm-4.11.17-r1
"

RDEPEND="${DEPEND}"
