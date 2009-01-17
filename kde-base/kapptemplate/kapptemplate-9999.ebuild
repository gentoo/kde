# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdesdk"
inherit kde4-meta

DESCRIPTION="KAppTemplate - A shell script to create the necessary framework to develop KDE applications."
KEYWORDS=""
IUSE="debug htmlhandbook"

# Fails, checked revision 810882.
RESTRICT="test"
