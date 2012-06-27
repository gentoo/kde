# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_DEPEND="*:2.5"
RESTRICT_PYTHON_ABIS="*-jython 2.4 2.7-pypy-*"
PYTHON_USE_WITH="threads"
SUPPORT_PYTHON_ABIS="1"

OPENGL_REQUIRED="always"
KDE_SCM="git"
inherit python portability kde4-base multilib

DESCRIPTION="Python bindings for KDE4"
KEYWORDS=""
IUSE="debug doc examples semantic-desktop"
REQUIRED_USE="test? ( semantic-desktop )"

# blocker added due to compatibility issues and error during compile time
RDEPEND="
	>=dev-python/sip-4.13.1
	$(add_kdebase_dep kdelibs 'opengl,semantic-desktop=')
	semantic-desktop? (
		$(add_kdebase_dep kdepimlibs 'semantic-desktop')
		>=dev-libs/soprano-2.7.56-r1
	)
	aqua? ( >=dev-python/PyQt4-4.9[dbus,declarative,sql,svg,webkit,aqua] )
	!aqua? ( >=dev-python/PyQt4-4.9[dbus,declarative,sql,svg,webkit,X] )
"
DEPEND="${RDEPEND}
	sys-devel/libtool
"

pkg_setup() {
	python_pkg_setup
	kde4-base_pkg_setup

	have_python2=false

	scan_python_versions() {
		[[ ${PYTHON_ABI} == 2.* ]] && have_python2=true
		:
	}
	python_execute_function -q scan_python_versions
	if ! ${have_python2}; then
		ewarn "You do not have a Python 2 version selected."
		ewarn "kpythonpluginfactory will not be built"
	fi
}

src_prepare() {
	kde4-base_src_prepare

	if ! use examples; then
		sed -e '/^ADD_SUBDIRECTORY(examples)/s/^/# DISABLED /' -i CMakeLists.txt \
			|| die "Failed to disable examples"
	fi

	# See bug 322351
	use arm && epatch "${FILESDIR}/${PN}-4.4.4-arm-sip.patch"

	sed -i -e 's/kpythonpluginfactory /kpython${PYTHON_SHORT_VERSION}pluginfactory /g' kpythonpluginfactory/CMakeLists.txt

	if ${have_python2}; then
		mkdir -p "${WORKDIR}/wrapper" || die "failed to copy wrapper"
		cp "${FILESDIR}/kpythonpluginfactorywrapper.c" "${WORKDIR}/wrapper" || die "failed to copy wrapper"
	fi
}

src_configure() {
	configuration() {
		local mycmakeargs=(
			-DWITH_PolkitQt=OFF
			-DWITH_QScintilla=OFF
			$(cmake-utils_use_with semantic-desktop Soprano)
			$(cmake-utils_use_with semantic-desktop Nepomuk)
			$(cmake-utils_use_with semantic-desktop KdepimLibs)
			-DPYTHON_EXECUTABLE=$(PYTHON -a)
		)
		local CMAKE_BUILD_DIR=${S}_build-${PYTHON_ABI}
		kde4-base_src_configure
	}

	python_execute_function configuration
}

echo_and_run() {
	echo "$@"
	"$@"
}

src_compile() {
	compilation() {
		local CMAKE_BUILD_DIR=${S}_build-${PYTHON_ABI}
		kde4-base_src_compile
	}
	python_execute_function compilation

	if ${have_python2}; then
		cd "${WORKDIR}/wrapper"
		echo_and_run libtool --tag=CC --mode=compile $(tc-getCC) \
			-shared \
			${CFLAGS} ${CPPFLAGS} \
			-DEPREFIX="\"${EPREFIX}\"" \
			-DPLUGIN_DIR="\"/usr/$(get_libdir)/kde4\"" -c \
			-o kpythonpluginfactorywrapper.lo \
			kpythonpluginfactorywrapper.c
		echo_and_run libtool --tag=CC --mode=link $(tc-getCC) \
			-shared -module -avoid-version \
			${CFLAGS} ${LDFLAGS} \
			-o kpythonpluginfactory.la \
			-rpath "${EPREFIX}/usr/$(get_libdir)/kde4" \
			kpythonpluginfactorywrapper.lo \
			$(dlopen_lib)
	fi
}

src_install() {
	installation() {
		cd "${S}_build-${PYTHON_ABI}"
		emake DESTDIR="${T}/images/${PYTHON_ABI}" install
	}
	python_execute_function installation

	python_merge_intermediate_installation_images "${T}/images"

	# As we don't call the eclass's src_install, we have to install the docs manually
	DOCS=("${S}"/{AUTHORS,NEWS,README})
	use doc && HTML_DOCS=("${S}/docs/html/")
	base_src_install_docs

	if ${have_python2}; then
		cd "${WORKDIR}/wrapper"
		echo_and_run libtool --mode=install install kpythonpluginfactory.la "${ED}/usr/$(get_libdir)/kde4/kpythonpluginfactory.la"
		rm "${ED}/usr/$(get_libdir)/kde4/kpythonpluginfactory.la"
	fi
}

pkg_postinst() {
	kde4-base_pkg_postinst

	python_mod_optimize PyKDE4 PyQt4/uic/pykdeuic4.py PyQt4/uic/widget-plugins/kde4.py

	if use examples; then
		echo
		elog "PyKDE4 examples have been installed to"
		elog "${EPREFIX}/usr/share/apps/${PN}/examples"
		echo
	fi
}

pkg_postrm() {
	kde4-base_pkg_postrm

	python_mod_cleanup PyKDE4 PyQt4/uic/pykdeuic4.py PyQt4/uic/widget-plugins/kde4.py
}
