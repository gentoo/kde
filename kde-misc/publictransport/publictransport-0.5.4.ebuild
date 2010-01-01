# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit kde4-base

DESCRIPTION="Find out when your bus/train is going."
HOMEPAGE="http://www.kde-look.org/content/show.php?content=106175"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/106175-${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=kde-base/plasma-workspace-${KDE_MINIMAL}"
RDEPEND="${DEPEND}"

DOCS="AUTHORS Changelog README"

src_prepare() {
	cat <<-EOF > "${S}/CMakeLists.txt"
add_subdirectory(plasma-applet-${P})
add_subdirectory(plasma-dataengine-${P})
add_subdirectory(${PN}-icons-${PV})
	EOF
	kde4-base_src_prepare
}
