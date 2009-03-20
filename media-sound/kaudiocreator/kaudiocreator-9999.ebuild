# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/multimedia"
inherit kde4-base

DESCRIPTION="KDE CD ripper and audio encoder frontend"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug"

DEPEND="
	>=kde-base/libkcompactdisc-${KDE_MINIMAL}[kdeprefix=]
	>=kde-base/libkcddb-${KDE_MINIMAL}[kdeprefix=]
"
RDEPEND="${DEPEND}"
