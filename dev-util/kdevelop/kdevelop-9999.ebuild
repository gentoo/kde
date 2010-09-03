# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

if [[ ${PV} != *9999* ]]; then
	KDE_LINGUAS="ca ca@valencia da de en_GB es et fr gl it nds pt pt_BR sv tr uk zh_CN zh_TW"
fi

KMNAME="kdevelop"
inherit kde4-base

DESCRIPTION="Integrated Development Environment for Unix, supporting KDE/Qt, C/C++ and many other languages."

LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
IUSE="+cmake +cxx debug okteta +qmake qthelp"

DEPEND="
	$(add_kdebase_dep ksysguard)
	$(add_kdebase_dep libkworkspace)
	okteta? ( $(add_kdebase_dep okteta) )
	qthelp? ( >=x11-libs/qt-assistant-4.4:4 )
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kapptemplate)
	cxx? ( >=sys-devel/gdb-7.0[python] )
"

src_prepare() {
	kde4-base_src_prepare

	# Remove this and the ksysguard dep after libprocessui moved into kdelibs
	sed -i -e 's/${KDE4WORKSPACE_PROCESSUI_LIBS}/processui/g' \
		debuggers/gdb/CMakeLists.txt \
		|| die "Failed to patch CMake files"
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build cmake)
		$(cmake-utils_use_build cmake cmakebuilder)
		$(cmake-utils_use_build cxx cpp)
		$(cmake-utils_use_with okteta LibKasten)
		$(cmake-utils_use_with okteta LibOkteta)
		$(cmake-utils_use_with okteta LibOktetaKasten)
		$(cmake-utils_use_build qmake)
		$(cmake-utils_use_build qmake qmakebuilder)
		$(cmake-utils_use_build qmake qmake_parser)
		$(cmake-utils_use_build qthelp)
	)

	kde4-base_src_configure
}
