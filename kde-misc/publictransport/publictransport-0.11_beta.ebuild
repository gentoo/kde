# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="Find out when your bus/train is going"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=106175"
SRC_URI="http://dev.gentoo.org/~creffett/distfiles/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug gps protobuf marble test"

DEPEND="
	$(add_kdebase_dep plasma-workspace)
	marble? ( $(add_kdebase_dep marble) )
	protobuf? ( dev-libs/protobuf )
"
RDEPEND="${DEPEND}
	x11-libs/qtscriptgenerator
"

RESTRICT="test"

src_configure() {
	local mycmakeargs=(
		-DINSTALL_APPLET_FLIGHTS=ON -DINSTALL_APPLET_GRAPHICALTIMETABLE=ON
		$(cmake-utils_use gps INSTALL_ENGINE_OPENSTREETMAP)
		$(cmake-utils_use_with marble)
		$(cmake-utils_use_with protobuf ProtocolBuffers)
		$(cmake-utils_use test BUILD_TESTS)
	)
	kde4-base_src_configure
}
