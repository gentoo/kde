# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME=kdebase-workspace
inherit kde4-base

DESCRIPTION="PowerDevil is an utility for KDE4 for Laptop Powermanagement"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="kde-base/systemsettings:${SLOT}
		kde-base/kscreensaver:${SLOT}
		!kdeprefix? ( !kde-misc/powerdevil )"
