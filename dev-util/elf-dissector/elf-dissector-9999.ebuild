# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST=true
KFMIN=6.0
QTMIN=6.7
inherit ecm kde.org

DESCRIPTION="Static analysis tool for ELF libraries and executables"
HOMEPAGE="https://invent.kde.org/sdk/elf-dissector"

LICENSE="BSD-2 GPL-2 LGPL-2+"
SLOT="0"
KEYWORDS=""

DEPEND="
	dev-libs/capstone:=
	dev-libs/libdwarf:=
	>=dev-qt/qtbase-${QTMIN}:6[widgets]
	sys-libs/binutils-libs:=
"
RDEPEND="${DEPEND}
	sci-visualization/gnuplot
"
