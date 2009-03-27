# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kinfocenter/kinfocenter-4.2.1.ebuild,v 1.4 2009/03/15 14:31:03 scarabeus Exp $

EAPI="2"

KMNAME="kdebase-apps"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="The KDE Info Center"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug ieee1394"

DEPEND="
	ieee1394? ( sys-libs/libraw1394 )
	opengl? ( virtual/glu virtual/opengl )
"
RDEPEND="${DEPEND}
	sys-apps/pciutils
	sys-apps/usbutils
"

KMEXTRACTONLY="
	cmake/modules/
"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with ieee1394 RAW1394)
		$(cmake-utils_use_with opengl OpenGL)"

	kde4-meta_src_configure
}
