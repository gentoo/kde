# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=2

inherit kde4-base git

DESCRIPTION="Bluetooth stack for KDE"
HOMEPAGE="http://gitorious.org/bluedevil"
EGIT_REPO_URI="git://gitorious.org/bluedevil/bluedevil.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	app-mobilephone/obexd
	app-mobilephone/obex-data-server
	>=kde-base/kdelibs-${KDE_MINIMAL}
	net-libs/libbluedevil
"
RDEPEND="${DEPEND}
	!net-wireless/kbluetooth"

src_prepare() {
	kde4-base_src_prepare

	sed -e 's/${KDE4WORKSPACE_SOLIDCONTROL_LIBRARY}/solidcontrol/g' \
		-i src/monolithic/CMakeLists.txt \
		|| die "Failed to patch CMake files"
}
