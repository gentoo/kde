# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebindings"
KMMODULE="generator"
inherit kde4-meta

DESCRIPTION="??"
KEYWORDS=""
IUSE=""

S="generator"

src_install() {
	insinto "${KDEDIR}"/bin
	doins "${S}"_build/generator/bin/generator

	insinto /usr/$(get_libdir)
	doins "${S}"_build/generator/bin/*.so
}
