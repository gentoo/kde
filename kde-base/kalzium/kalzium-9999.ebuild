# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeedu"
CPPUNIT_REQUIRED="optional"
OPENGL_REQUIRED="always"
inherit kde4-meta

DESCRIPTION="KDE: periodic table of the elements."
KEYWORDS=""
IUSE="editor debug +plasma solver"

DEPEND="
	>=kde-base/libkdeedu-${PV}:${SLOT}[kdeprefix=]
	editor? (
		>=dev-cpp/eigen-1.0.5
		>=sci-chemistry/openbabel-2.2
	)
	solver? ( dev-ml/facile[ocamlopt] )
"
RDEPEND="${RDEPEND}"

KMEXTRACTONLY="
	libkdeedu/kdeeduui/
	libkdeedu/libscience/
"

src_configure(){
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with editor Eigen)
		$(cmake-utils_use_with editor OpenBabel2)
		$(cmake-utils_use_with editor OpenGL)
		$(cmake-utils_use_with solver OCaml)
		$(cmake-utils_use_with solver Libfacile)"

	sed -i -e "s:add_subdirectory(cmake):#dontwantit:g" CMakeLists.txt \
		|| die  "disabling cmake includes failed"
	sed -i -e "s:add_subdirectory( cmake ):#dontwantit:g" CMakeLists.txt \
		|| die "disabling cmake includes failed"

	if use solver; then
		# Compile the solver on its own as the cmake-based build is
		# currently broken. Fixes bug 206620.
		pushd "${S}/${PN}/src/solver" >/dev/null
		emake || die "compiling the ocaml resolver failed"
		mkdir -p "${WORKDIR}/${PN}_build/${PN}/src/"
		cp * "${WORKDIR}/${PN}_build/${PN}/src/"
		popd >/dev/null
	fi

	kde4-meta_src_configure
}
