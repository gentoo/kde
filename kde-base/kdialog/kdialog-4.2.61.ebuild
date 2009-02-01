# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-apps"
inherit kde4-meta

DESCRIPTION="KDialog can be used to show nice dialog boxes from shell scripts"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="
	kernel_linux? (
		|| (
			sys-apps/eject
			sys-block/unieject
		)
	)
"
