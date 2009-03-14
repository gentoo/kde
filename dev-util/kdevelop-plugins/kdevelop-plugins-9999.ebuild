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
IUSE="+automake +browser +debugger +php +python +ruby"

DEPEND="
	>=dev-util/kdevelop-${PV}:${SLOT}[kdeprefix=]
	automake? ( sys-devel/automake )
	php? ( dev-lang/php )
	python? ( dev-lang/python )
	ruby? ( dev-lang/ruby )
"
RDEPEND="${DEPEND}"

src_prepare() {
	#generate basic cmakelists.txt
	cat <<-EOF > "${S}/CMakeLists.txt"
find_package(KDE4 REQUIRED)
find_package(KDevPlatform REQUIRED)
EOF
	find ./ -mindepth 1 -maxdepth 1 -type d -print | while read dir; do
		echo "macro_optional_add_subdirectory ( \"${dir}\" ) " > "${S}/CMakeLists.txt"
	done
}

src_configure() {
	mycmakeargs="$(cmake-utils_use_build automake)
		$(cmake-utils_use_build browser classbrowser)
		$(cmake-utils_use_build debugger)
		$(cmake-utils_use_build php)
		$(cmake-utils_use_build python)
		$(cmake-utils_use_build ruby)"

	kde4-base_src_configure
}
