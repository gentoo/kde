# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

# this lib is extragear but live kde-base ebuilds depend on it
# (ark, nepomuk, plasma-workspace)
# we're keeping it in kde-base/ for now to avoid confusion
KMNAME="extragear/libs"
inherit kde4-meta

DESCRIPTION="Notification library"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	!=kde-base/plasma-workspace-9999[kdeprefix=]
	"
