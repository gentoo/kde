# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics-meta/kdegraphics-meta-4.2.3.ebuild,v 1.1 2009/05/06 23:10:06 scarabeus Exp $

EAPI="2"

inherit kde4-functions

DESCRIPTION="kdegraphics - merge this to pull in all kdegraphics-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="
	>=kde-base/gwenview-${PV}:${SLOT}
	>=kde-base/kamera-${PV}:${SLOT}
	>=kde-base/kcolorchooser-${PV}:${SLOT}
	>=kde-base/kgamma-${PV}:${SLOT}
	>=kde-base/kolourpaint-${PV}:${SLOT}
	>=kde-base/kruler-${PV}:${SLOT}
	>=kde-base/ksaneplugin-${PV}:${SLOT}
	>=kde-base/ksnapshot-${PV}:${SLOT}
	>=kde-base/libkdcraw-${PV}:${SLOT}
	>=kde-base/libkexiv2-${PV}:${SLOT}
	>=kde-base/libkipi-${PV}:${SLOT}
	>=kde-base/libksane-${PV}:${SLOT}
	>=kde-base/okular-${PV}:${SLOT}
	>=kde-base/svgpart-${PV}:${SLOT}
	>=kde-base/kdegraphics-strigi-analyzer-${PV}:${SLOT}
"
