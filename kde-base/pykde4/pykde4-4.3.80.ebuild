# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebindings"
KMMODULE="python/${PN}"
OPENGL_REQUIRED="always"
PYTHON_USE_WITH="threads"
SUPPORT_PYTHON_ABIS="1"
inherit python kde4-meta

DESCRIPTION="Python bindings for KDE4"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="akonadi debug examples policykit semantic-desktop"

COMMON_DEPEND="
	>=dev-python/PyQt4-4.5[dbus,sql,svg,webkit,X]
	$(add_kdebase_dep kdelibs 'opengl,semantic-desktop?')
	akonadi? ( $(add_kdebase_dep kdepimlibs) )
	policykit? ( >=sys-auth/policykit-qt-0.9.2 )
"
DEPEND="${COMMON_DEPEND}"
# blocker added due to compatibility issues and error during compile time
RDEPEND="${COMMON_DEPEND}
	!dev-python/pykde
"

PATCHES=(
	"${FILESDIR}/${PN}-python3.patch"
)

pkg_setup() {
	python_pkg_setup
	kde4-meta_pkg_setup
}

src_prepare() {
	kde4-meta_src_prepare

	if ! use examples; then
		sed -e '/^ADD_SUBDIRECTORY(examples)/s/^/# DISABLED /' -i python/${PN}/CMakeLists.txt \
			|| die "Failed to disable examples"
	fi

	python_copy_sources
}

src_configure() {
	savedcmakeargs="${mycmakeargs}
		-DWITH_QScintilla=OFF
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with akonadi)
		$(cmake-utils_use_with akonadi KdepimLibs)
		$(cmake-utils_use_with policykit PolkitQt)
	"

	do_src_configure() {
		mycmakeargs="${savedcmakeargs}"

		CMAKE_USE_DIR="${S}-${PYTHON_ABI}"
		kde4-meta_src_configure

		export savedcmakeargs_${PYTHON_ABI//./_}="${mycmakeargs}"
	}

	python_execute_function -s do_src_configure
}

src_compile() {
	do_src_compile() {
		CMAKE_USE_DIR="${S}-${PYTHON_ABI}"
		kde4-meta_src_compile
	}

	python_execute_function -s do_src_compile
}

src_test() {
	do_src_test() {
		local var="savedcmakeargs_${PYTHON_ABI//./_}"
		mycmakeargs="${!var}"

		CMAKE_USE_DIR="${S}-${PYTHON_ABI}"
		kde4-meta_src_test
		export ${var}="${mycmakeargs}"
	}

	python_execute_function -s do_src_test
}

src_install() {
	do_src_install() {
		CMAKE_USE_DIR="${S}-${PYTHON_ABI}"
		kde4-meta_src_install

		rm -f "${D}$(python_get_sitedir)"/PyKDE4/*.py[co]
	}

	python_execute_function -s do_src_install
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	python_mod_optimize PyKDE4

	if use examples; then
		echo
		elog "PyKDE4 examples have been installed to"
		elog "${PREFIX}/share/apps/${PN}/examples"
		echo
	fi
}

pkg_postrm() {
	kde4-meta_pkg_postrm

	python_mod_cleanup PyKDE4
}
