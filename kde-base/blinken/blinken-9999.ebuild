# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdeedu
inherit kde4svn-meta

DESCRIPTION="KDE version of the Simon Says game."
KEYWORDS=""
IUSE="debug htmlhandbook"

COMMONDEPEND=">=kde-base/libkdeedu-${PV}:${SLOT}"
DEPEND="${COMMONDEPEND}"
RDEPEND="${COMMONDEPEND}
	>=kde-base/knotify-${PV}:${SLOT}"

KMEXTRACTONLY=libkdeedu/kdeeduui
