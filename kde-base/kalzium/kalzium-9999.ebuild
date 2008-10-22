# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdeedu
CPPUNIT_REQUIRED="optional"
OPENGL_REQUIRED="always"
inherit kde4svn-meta

DESCRIPTION="KDE: periodic table of the elements."
KEYWORDS=""
IUSE="cviewer debug htmlhandbook +plasma solver"

COMMONDEPEND=">=kde-base/libkdeedu-${PV}:${SLOT}
	cviewer? ( >=dev-cpp/eigen-1.0.5
		>=sci-chemistry/openbabel-2.1 )"
DEPEND="${DEPEND} ${COMMONDEPEND}
	plasma? ( kde-base/libplasma:${SLOT} )
	solver? ( || ( >=dev-lang/ocaml-3.10.1_rc2
			<dev-lang/ocaml-3.10.1_rc2 )
		dev-ml/facile )"
RDEPEND="${RDEPEND} ${COMMONDEPEND}"

KMEXTRACTONLY="libkdeedu/kdeeduui libkdeedu/libscience"

pkg_setup() {
	if use solver && ! built_with_use dev-lang/ocaml ocamlopt && ! built_with_use dev-ml/facile ocamlopt ; then
		eerror "In order to build "
		eerror "you need dev-lang/ocaml and dev-ml/facile built with ocamlopt  USE flag "
		die "no ocamlopt in ocaml and facile"
	fi
}

src_compile() {
	if use solver; then
		# Compile the solver on its own as the cmake-based build is
		# currently broken. Fixes bug 206620.
		pushd "${S}/${PN}/src/solver" >/dev/null
		emake || die "compiling the ocaml resolver failed"
		mkdir -p "${WORKDIR}/${PN}_build/${PN}/src/"
		cp * "${WORKDIR}/${PN}_build/${PN}/src/"
		popd >/dev/null
	fi

	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with cviewer Eigen)
		$(cmake-utils_use_with cviewer OpenBabel2)
		$(cmake-utils_use_with cviewer OpenGL)
		$(cmake-utils_use_with plasma Plasma)
		$(cmake-utils_use_with solver OCaml)
		$(cmake-utils_use_with solver Libfacile)"

	kde4overlay-meta_src_compile
}
