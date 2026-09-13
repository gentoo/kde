# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST=true
KFMIN=6.9.0
QTMIN=6.7
inherit ecm kde.org xdg

DESCRIPTION="Static analysis tool for ELF libraries and executables"
HOMEPAGE="https://invent.kde.org/sdk/elf-dissector"

LICENSE="BSD-2 GPL-2 LGPL-2+"
SLOT="0"
KEYWORDS=""

IUSE="capstone"

# libdwarf supports appears to have issues with >=2.0.0
#dwarf? ( >=dev-libs/libdwarf-0.10:= )
DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[widgets]
	sys-libs/binutils-libs:=
	capstone? ( dev-libs/capstone:= )
"
RDEPEND="${DEPEND}
	sci-visualization/gnuplot
"

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package capstone Capstone)
		-DCMAKE_DISABLE_FIND_PACKAGE_Dwarf=ON
		#$(cmake_use_find_package dwarf Dwarf)
	)
	ecm_src_configure
}
