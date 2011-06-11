# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"

if [[ ${PV} == *9999 ]]; then
	kde_eclass="kde4-base"
else
	KMNAME="kdeedu"
	KMEXTRACTONLY="libkdeedu/libscience kalzium"
	KMEXTRA="kalzium/libscience"
	kde_eclass="kde4-meta"
fi

inherit ${kde_eclass}

DESCRIPTION="Common library for KDE educational apps"
KEYWORDS=""
IUSE="debug"

EGIT_BRANCH="4.6"

# 4 of 4 tests fail. Last checked for 4.6.1. Tests are fundamentally broken, 
# see bug 258857 for details.
RESTRICT=test
