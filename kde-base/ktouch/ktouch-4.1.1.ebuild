# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdeedu
inherit kde4-meta

DESCRIPTION="KDE: A program that helps you to learn and practice touch typing"
HOMEPAGE="http://ktouch.sourceforge.net/"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

RDEPEND=">=kde-base/knotify-${PV}:${SLOT}"
