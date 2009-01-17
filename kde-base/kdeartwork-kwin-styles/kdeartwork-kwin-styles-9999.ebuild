# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeartwork"
KMMODULE="kwin-styles"
inherit kde4-meta

DESCRIPTION="window styles for kde"
KEYWORDS=""
IUSE=""

src_prepare() {
	kde4-base_src_compile

	sed -i -e "s:#macro_optional_add_subdirectory(kwin-styles):macro_optional_add_subdirectory(kwin-styles):" "${S}"/CMakeLists.txt
}