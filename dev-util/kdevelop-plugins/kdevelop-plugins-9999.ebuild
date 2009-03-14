# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KMNAME="playground/devtools"
KMMODULE="kdevelop4-extra-plugins"
inherit kde4-base

DESCRIPTION="Various plugins for kdevelop (support for other langs)"
HOMEPAGE="http://www.kdevelop.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="4"
KEYWORDS=""
IUSE="+browser +debugger +php"

DEPEND="
	>=dev-util/kdevelop-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}"

src_prepare() {
	local dir enabled
	#generate basic cmakelists.txt
	cat <<-EOF > "${S}/CMakeLists.txt"
find_package(KDE4 REQUIRED)
find_package(KDevPlatform REQUIRED)
EOF
# # # search based on path
#	find ./ -mindepth 1 -maxdepth 1 -type d -print |sed -e "s:./::g"| \
#	sort | while read dir; do
	enabled="classbrowser debugger php"
	for dir in ${enabled}; do
		echo "macro_optional_add_subdirectory(${dir}) " >> "${S}/CMakeLists.txt"
	done
}

src_configure() {
	mycmakeargs="
		$(cmake-utils_use_build browser classbrowser)
		$(cmake-utils_use_build debugger)
		$(cmake-utils_use_build php)"

	kde4-base_src_configure
}
