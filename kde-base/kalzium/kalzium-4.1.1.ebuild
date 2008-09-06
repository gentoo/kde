# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalzium/kalzium-4.0.5.ebuild,v 1.2 2008/07/27 19:07:30 carlo Exp $

EAPI="1"

KMNAME=kdeedu
CPPUNIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="KDE: periodic table of the elements."
KEYWORDS="~amd64 ~x86"
IUSE="editor debug htmlhandbook solver"

COMMONDEPEND=">=kde-base/libkdeedu-${PV}
	editor? ( >=dev-cpp/eigen-1.0.5
		>=sci-chemistry/openbabel-2.2
		|| ( x11-libs/qt-opengl:4
			=x11-libs/qt-4.3*:4 )
		virtual/opengl )"
DEPEND="${DEPEND} ${COMMONDEPEND}
	solver? ( dev-ml/facile )"
RDEPEND="${RDEPEND} ${COMMONDEPEND}"

KMEXTRACTONLY="libkdeedu/kdeeduui libkdeedu/libscience"

PATCHES=("${FILESDIR}/${KMNAME}-4.1.0-cmake_modules.patch")

pkg_setup() {
	if use editor && has_version '<x11-libs/qt-4.4.0_alpha:4'; then
		QT4_BUILT_WITH_USE_CHECK="${QT4_BUILT_WITH_USE_CHECK} opengl"
	fi

	if use solver && ! built_with_use dev-ml/facile ocamlopt; then
		eerror "please build dev-ml/facile with ocamlopt useflag"
		die "need ocamlopt useflag on facile"
	fi

	kde4-meta_pkg_setup
}

src_compile() {
	if use solver ; then
		# Compile the solver on its own as the cmake-based build is
		# currently broken. Fixes bug 206620.
		cd "${S}/${PN}/src/solver"
		emake || die "compiling the ocaml resolver failed"
		mkdir -p "${WORKDIR}/${PN}_build/${PN}/src/"
		cp * "${WORKDIR}/${PN}_build/${PN}/src/"
	fi

	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with editor Eigen)
		$(cmake-utils_use_with editor OpenBabel2)
		$(cmake-utils_use_with editor OpenGL)
		$(cmake-utils_use_with solver OCaml)
		$(cmake-utils_use_with solver Libfacile)"

	kde4-meta_src_compile
}
