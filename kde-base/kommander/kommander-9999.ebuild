# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME=kdewebdev
EAPI="1"
SLOT="kde-svn"
inherit kde4svn-meta

DESCRIPTION="KDE dialog system for scripting"
KEYWORDS=""
IUSE=""

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with tidy LibTidy)"
	kde4overlay-meta_src_compile
}
