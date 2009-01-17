# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/utils"
inherit kde4-base

DESCRIPTION="KDE-based frontend to diff3"
HOMEPAGE="http://kdiff3.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="live"
IUSE="debug"

RDEPEND="sys-apps/diffutils"
