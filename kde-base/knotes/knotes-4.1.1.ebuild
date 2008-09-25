# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2_pre3"

KMNAME=kdepim
inherit kde4-meta

DESCRIPTION="KDE Notes"
IUSE="debug"
KEYWORDS="~amd64 ~x86"

DEPEND="kde-base/libkdepim:${SLOT}"

KMEXTRACTONLY="libkdepim"
KMLOADLIBS="libkdepim"
