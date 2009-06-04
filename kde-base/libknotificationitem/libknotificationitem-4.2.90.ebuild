# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdelibs-experimental"
KMMODULE="knotificationitem"
inherit kde4-meta

DESCRIPTION="Notification library"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="
	!=kde-base/plasma-workspace-9999[kdeprefix=]
"
