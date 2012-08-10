# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libkface/libkface-2.7.0.ebuild,v 1.1 2012/07/09 20:40:31 dilfridge Exp $

EAPI=4

DIGIKAMPN=digikam

KDE_LINGUAS=""
KDE_MINIMAL="4.8"

CMAKE_MIN_VERSION=2.8

inherit kde4-base

MY_PV=${PV/_/-}
MY_P="digikam-${MY_PV}"
SRC_URI="mirror://sourceforge/digikam/${MY_P}.tar.bz2"

DESCRIPTION="Qt/C++ wrapper around LibFace to perform face recognition and detection"
HOMEPAGE="http://www.digikam.org/"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""
SLOT=4

DEPEND="media-libs/opencv"
RDEPEND=${DEPEND}

S=${WORKDIR}/${MY_P}/extra/${PN}

src_configure() {
	mycmakeargs=(
		-DFORCED_UNBUNDLE=ON
	)
	kde4-base_src_configure
}
