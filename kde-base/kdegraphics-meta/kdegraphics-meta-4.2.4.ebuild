# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics-meta/kdegraphics-meta-4.2.3.ebuild,v 1.1 2009/05/06 23:10:06 scarabeus Exp $

EAPI="2"

DESCRIPTION="kdegraphics - merge this to pull in all kdegraphics-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="kdeprefix"

RDEPEND="
	>=kde-base/gwenview-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kamera-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kcolorchooser-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kdegraphics-strigi-analyzer-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kgamma-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kolourpaint-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kruler-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/ksaneplugin-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/ksnapshot-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libkdcraw-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libkexiv2-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libkipi-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libksane-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/okular-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/svgpart-${PV}:${SLOT}[kdeprefix=]
"
