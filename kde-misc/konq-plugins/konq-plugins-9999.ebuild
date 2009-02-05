# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/base"
KDE_MIMIMAL="4.2"
inherit kde4-meta

DESCRIPTION="Various plugins for konqueror"
HOMEPAGE="http://kde.org/"
SLOT="live"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="debug htmlhandbook"

DEPEND="
	>=kde-base/libkonq-${KDE_MINIMAL}[kdeprefix=]
"
RDEPEND="${DEPEND}
	!kde-base/konq-plugins[-kdeprefix]
	!kde-base/konq-plugins:${SLOT}[kdeprefix]
	>=kde-base/konqueror-${KDE_MINIMAL}[kdeprefix=]
"

src_prepare() {
	if ! use htmlhandbook; then
		sed -i \
			-e "s:macro_optional_add_subdirectory(doc):#nada:g" \
			CMakeLists.txt || die "sed doc failed"
	fi

	kde4-meta_src_prepare
}
