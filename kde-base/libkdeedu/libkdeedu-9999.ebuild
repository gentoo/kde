# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
if [[ ${PV} == *9999 ]]; then
	KDE_SCM="git"
	inherit kde4-base
else
	KMNAME="kdeedu"
	inherit kde4-meta
fi

DESCRIPTION="Common library for KDE educational apps"
KEYWORDS=""
IUSE="debug"

# 4 of 4 tests fail. Last checked for 4.6.1. Tests are fundamentally broken, 
# see bug 258857 for details.
RESTRICT=test
