# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit cmake-utils

DESCRIPTION="Set of library for using and integrating transformation algorithms"
HOMEPAGE="http://opengtl.org/"
SRC_URI="${HOMEPAGE}download/OpenGTL-${PV}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	media-libs/libpng
	media-libs/libopenraw
	sys-libs/llvm
"
# sys-libs/llvm not around and i dont want to do it now
# somebody should do it
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6"

src_prepare() {
	# fix werror
	sed -i \
		-e "s:-Werror::g" \
		CMakeLists.txt || die "sed failed"
}

src_install() {
	cmake-utils_src_install
	newdoc OpenShiva/doc/specifications/region.pdf OpenShiva.pdf
}
