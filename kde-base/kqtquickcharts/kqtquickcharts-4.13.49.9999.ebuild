# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdf/kdf-4.13.0.ebuild,v 1.2 2014/04/17 00:43:14 johu Exp $

EAPI=5

DECLARATIVE_REQUIRED="always"
inherit kde4-base

DESCRIPTION="Qt Quick 1 plugin for beautiful and interactive charts"
KEYWORDS=""
IUSE="debug"

RDEPEND="$(add_kdebase_dep plasma-workspace '' 4.11)"
