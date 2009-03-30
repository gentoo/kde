# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="KDE4 plasmoid. Displays the currect signal strength."
HOMEPAGE="http://www.kde-look.org/content/show.php/cpuload?content=79476"
SRC_URI="http://kde-look.org/CONTENT/content-files/79476-${P}.tgz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

RDEPEND="
	!kde-plasmoids/plasma-wifi
	>=kde-base/plasma-workspace-${KDE_MINIMAL}
"

src_prepare() {
	sed -i "s:find_package(Plasma REQUIRED)::" CMakeLists.txt || die "sed failed"
	sed -i "s:PLASMA_LIBS:KDE4_PLASMA_LIBS:" CMakeLists.txt || die "sed failed"

	kde4-base_src_prepare
}
