# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdeedu
inherit kde4svn-meta

DESCRIPTION="KDE: A program that helps you to learn and practice touch typing"
KEYWORDS=""
IUSE="debug htmlhandbook"

RDEPEND=">=kde-base/knotify-${PV}:${SLOT}"
