# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeadmin"
KMMODULE="ksystemlog"
inherit kde4-meta

DESCRIPTION="KSystemLog is a system log viewer for KDE."
KEYWORDS=""
IUSE="debug htmlhandbook"

DEPEND="kde-base/kdepimlibs:${SLOT}"
