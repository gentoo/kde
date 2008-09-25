# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2_pre3"

KMNAME=kdegraphics
inherit kde4-meta eutils

DESCRIPTION="Paint Program for KDE"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"
LICENSE="BSD LGPL-2"

DEPEND="kde-base/qimageblitz"
RDEPEND="${DEPEND}"
