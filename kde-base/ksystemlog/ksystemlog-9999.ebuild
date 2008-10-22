# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdeadmin
KMMODULE=ksystemlog
inherit kde4svn-meta

DESCRIPTION="KSystemLog is a system log viewer for KDE."
KEYWORDS=""
IUSE="debug htmlhandbook"

# Last checked at revision 810998.
RESTRICT="test"
DEPEND="kde-base/kdepimlibs:${SLOT}"
