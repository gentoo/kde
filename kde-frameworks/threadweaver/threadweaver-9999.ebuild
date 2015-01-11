# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="Framework for managing threads using job and queue-based interfaces"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="dev-qt/qtwidgets:5"
DEPEND="${RDEPEND}"

src_prepare() {
	comment_add_subdirectory benchmarks
	kde5_src_prepare
}
