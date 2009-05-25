# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit cmake-utils

DESCRIPTION="Set of libraries for using and integrating transformation algorithms"
HOMEPAGE="http://opengtl.org/"
SRC_URI="${HOMEPAGE}download/OpenGTL-${PV}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	media-libs/libpng
	media-libs/libopenraw
	=sys-devel/llvm-2.5
"
# =sys-devel/llvm-2.5 is on bug #186279

DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6"

src_install() {
	cmake-utils_src_install
	newdoc OpenShiva/doc/specifications/region.pdf OpenShiva.pdf
}
