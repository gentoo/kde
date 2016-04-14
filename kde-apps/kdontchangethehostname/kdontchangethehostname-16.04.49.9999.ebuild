# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="Tool to inform Plasma about a change in hostname"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	x11-apps/xauth
"
