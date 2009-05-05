# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalzium/kalzium-4.2.2.ebuild,v 1.2 2009/04/17 07:54:16 alexxy Exp $

EAPI="2"

KMNAME="kdeedu"
CPPUNIT_REQUIRED="optional"
OPENGL_REQUIRED="always"
inherit kde4-meta

DESCRIPTION="KDE: periodic table of the elements."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="editor debug doc +plasma solver"

COMMON_DEPEND="
	>=kde-base/libkdeedu-${PV}:${SLOT}[kdeprefix=]
	editor? ( >=sci-chemistry/openbabel-2.2 )
"
DEPEND="${COMMON_DEPEND}
	editor? ( >=dev-cpp/eigen-1.0.5 )
	solver? ( dev-ml/facile[ocamlopt] )
"
RDEPEND="${COMMON_DEPEND}"

KMEXTRACTONLY="
	libkdeedu/kdeeduui/
	libkdeedu/libscience/
"

PATCHES=( "${FILESDIR}/${P}-include-order.patch" )

src_configure(){
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with editor Eigen)
		$(cmake-utils_use_with editor OpenBabel2)
		$(cmake-utils_use_with editor OpenGL)
		$(cmake-utils_use_with solver OCaml)
		$(cmake-utils_use_with solver Libfacile)"

	kde4-meta_src_configure
}
