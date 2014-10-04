# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_NLS="false"
inherit kde5

DESCRIPTION="Framework for managing threads using job and queue-based interfaces"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

src_prepare() {
	comment_add_subdirectory benchmarks
	kde5_src_prepare
}
