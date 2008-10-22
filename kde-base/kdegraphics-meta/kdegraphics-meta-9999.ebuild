# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit kde4overlay-functions

DESCRIPTION="kdegraphics - merge this to pull in all kdegraphics-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="kde-svn"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=kde-base/gwenview-${PV}:${SLOT}
	>=kde-base/kamera-${PV}:${SLOT}
	>=kde-base/kcolorchooser-${PV}:${SLOT}
	>=kde-base/kgamma-${PV}:${SLOT}
	>=kde-base/kolourpaint-${PV}:${SLOT}
	>=kde-base/kruler-${PV}:${SLOT}
	>=kde-base/ksnapshot-${PV}:${SLOT}
	>=kde-base/libksane-${PV}:${SLOT}
	>=kde-base/okular-${PV}:${SLOT}
	>=kde-base/svgpart-${PV}:${SLOT}
	>=kde-base/kdegraphics-strigi-analyzer-${PV}:${SLOT}
"
