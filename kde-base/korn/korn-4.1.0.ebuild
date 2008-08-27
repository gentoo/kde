# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdepim
inherit kde4-meta

DESCRIPTION="KDE mailbox checker"
IUSE="debug"
KEYWORDS="~amd64 ~x86"

KMEXTRACTONLY="kmail"

src_compile() {
    # korn was disabled upstream
	sed -i -e 's/#  macro_optional_add_subdirectory(korn)/macro_optional_add_subdirectory(korn)/' "${S}"/CMakeLists.txt \
		|| die "sed to enable korn failed"

	kde4-meta_src_test
}
