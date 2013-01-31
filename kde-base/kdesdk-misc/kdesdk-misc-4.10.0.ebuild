# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kdesdk"
KMNOMODULE="true"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="KDE miscellaneous SDK tools"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug extras"

DEPEND="
	extras? ( >=dev-java/antlr-2.7.7:0[cxx,java,script] )
"
RDEPEND="${DEPEND}"

KMEXTRA="
	doc/kmtrace/
	doc/poxml/
	kmtrace/
	kpartloader/
	kprofilemethod/
	poxml/
"
# java deps on anltr cant be properly explained to cmake deps
# needs to be run in one thread
MAKEOPTS+=" -j1"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with extras Antlr2)
	)

	kde4-meta_src_configure
}
