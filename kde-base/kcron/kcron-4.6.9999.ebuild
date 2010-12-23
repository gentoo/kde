# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KDE_HANDBOOK="optional"
KMNAME="kdeadmin"
inherit kde4-meta

DESCRIPTION="KDE Task Scheduler"
KEYWORDS=""
IUSE="debug"

RDEPEND="!prefix? ( virtual/cron )"
