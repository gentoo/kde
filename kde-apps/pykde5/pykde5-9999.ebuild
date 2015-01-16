# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )
PYTHON_REQ_USE="threads"
OPENGL_REQUIRED="always"

inherit python-r1 portability kde5 multilib eutils

DESCRIPTION="Python bindings for KDE Applications 5"
KEYWORDS=""
IUSE="doc"
HOMEPAGE="http://techbase.kde.org/Development/Languages/Python"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kauth)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep kitemmodels)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kplotting)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep sonnet)
	dev-python/PyQt5[${PYTHON_USEDEP},gui,widgets]
	>=dev-python/sip-4.16.2:=[${PYTHON_USEDEP}]
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"

DEPEND="${RDEPEND}
	doc? ( $(add_frameworks_dep kapidox) )
"

src_prepare() {
	kde5_src_prepare

	python_copy_sources
}

src_configure() {
	configuration() {
		local mycmakeargs=(
			-DPYTHON_EXECUTABLE=${PYTHON}
		)
		local CMAKE_BUILD_DIR=${S}_build-${PYTHON_ABI}
		kde5_src_configure
	}

	python_foreach_impl run_in_build_dir configuration
}

src_compile() {
	compilation() {
		local CMAKE_BUILD_DIR=${S}_build-${PYTHON_ABI}
		kde5_src_compile
	}
	python_foreach_impl run_in_build_dir compilation
}

src_test() {
	python_foreach_impl run_in_build_dir kde5_src_test
}

src_install() {
	installation() {
		emake DESTDIR="${D}" install

		python_optimize
	}
	python_foreach_impl run_in_build_dir installation

	# As we don't call the eclass's src_install, we have to install the docs manually
	use doc && HTML_DOCS=("${S}/docs/html/")
	einstalldocs
}
