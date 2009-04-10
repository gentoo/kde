# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/multimedia"
inherit kde4-base

DESCRIPTION="KDE front-end tool for ripping and encoding CD's"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="
	>=kde-base/libkcompactdisc-${KDE_MINIMAL}
	>=kde-base/libkcddb-${KDE_MINIMAL}
	taglib? ( >=media-libs/taglib-1.5 )
"
RDEPEND="${DEPEND}
	!kdeprefix? ( !media-sound/kaudiocreator:3.5 )
"

src_prepare() {
	kde4-base_src_prepare
	# fix automagicness for taglib
	sed -i \
		-e "s:find_package(Taglib):macro_optional_find_package(Taglib):g" \
		CMakeLists.txt || die "sed fixing automagic failed."
}

src_configure() {
	mycmakeargs="$(cmake-utils_use_with taglib)"
	kde4-base_src_configure
}
