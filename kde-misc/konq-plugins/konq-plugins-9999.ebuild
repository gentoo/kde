# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/base"
KMNOMODULE="true"
inherit kde4-base

DESCRIPTION="Various plugins for konqueror"
HOMEPAGE="htts://kde.org/"
SLOT="live"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="debug htmlhandbook"

RDEPEND=">=kde-base/konqueror-${KDE_MINIMAL}"
DEPEND="${RDEPEND}"

src_prepare() {
	if ! use htmlhandbook; then
		sed -i \
			-e "s:macro_optional_add_subdirectory(doc):#nada:g" \
			CMakeLists.txt || die "sed doc failed"
	fi
}
