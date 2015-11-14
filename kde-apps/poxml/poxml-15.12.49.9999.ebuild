# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_HANDBOOK="true"
KDE_PUNT_BOGUS_DEPS="true"
inherit kde5

DESCRIPTION="KDE utility to translate DocBook XML files using gettext po files"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-qt/qtxml:5
	sys-devel/gettext
"
RDEPEND="${DEPEND}"
