# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit cmake-utils git-r3 python-any-r1

DESCRIPTION="Extra modules and scripts for CMake"
HOMEPAGE="https://projects.kde.org/projects/kdesupport/extra-cmake-modules"
EGIT_REPO_URI=( "git://anongit.kde.org/${PN}" )

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="doc"

DEPEND="
	>=dev-util/cmake-2.8.12
	doc? (
		${PYTHON_DEPS}
		$(python_gen_any_dep 'dev-python/sphinx[${PYTHON_USEDEP}]')
	)
"

python_check_deps() {
	has_version "dev-python/sphinx[${PYTHON_USEDEP}]"
}

pkg_setup() {
	use doc && python-any-r1_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build doc HTML_DOCS)
		$(cmake-utils_use_build doc MAN_DOCS)
	)

	cmake-utils_src_configure
}
