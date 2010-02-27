# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdeedu"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="MathML-based graph calculator for KDE."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook +plasma readline"

DEPEND="
	readline? ( sys-libs/readline )
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libkdeedu/kdeeduui"

PATCHES=(
	"${FILESDIR}"/${PN}-4.3.2-solaris-graph2d.patch
)

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with readline)
		$(cmake-utils_use_with plasma)
		$(cmake-utils_use_with opengl OpenGL)
	)

	kde4-meta_src_configure
}

src_test() {
	# disable broken test
	sed -i -e '/mathmlpresentationtest/ s/^/#DO_NOT_RUN_TEST /' \
		"${S}"/"${PN}"/analitza/tests/CMakeLists.txt || \
		die "sed to disable mathmlpresentationtest failed."

	kde4-meta_src_test
}
