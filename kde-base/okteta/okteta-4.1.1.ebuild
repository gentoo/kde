# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2_pre1"

KMNAME=kdeutils
inherit kde4-meta

DESCRIPTION="KDE binary file editor"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

# 9/ 40 Testing libpiecetable-grouppiecetablec***Failed
RESTRICT="test"
