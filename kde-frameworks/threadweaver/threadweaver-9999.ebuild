# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit ecm kde.org

DESCRIPTION="Framework for managing threads using job and queue-based interfaces"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

src_prepare() {
	cmake_comment_add_subdirectory benchmarks
	ecm_src_prepare
}
