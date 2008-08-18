# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdebase-runtime
KMMODULE=phonon
inherit kde4-meta

DESCRIPTION="KDE Phonon Xine backend"
KEYWORDS="~amd64 ~x86"
IUSE="debug +xcb"

# There's currently only a xine backend for phonon available,
# a gstreamer backend from TrollTech is in the works.
DEPEND="!kde-base/phonon:${SLOT}
	>=media-sound/phonon-4.2.0
	>=media-libs/xine-lib-1.1.9
	xcb? ( x11-libs/libxcb )"
RDEPEND="${DEPEND}"

# Gentoo bug 234926 and KDE bug 169365
# The real fix is on xine headers and this is just a workaround
PATCHES=("${FILESDIR}/support-xine-lib-1.1.15.patch")

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with xcb XCB)
		-DWITH_Xine=ON"

	kde4-meta_src_compile
}
