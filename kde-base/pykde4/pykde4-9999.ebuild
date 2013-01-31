# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7,3_1,3_2} )
PYTHON_REQ_USE="threads"
OPENGL_REQUIRED="always"

inherit python-r1 portability kde4-base multilib

DESCRIPTION="Python bindings for KDE4"
KEYWORDS=""
IUSE="debug doc examples semantic-desktop test"
REQUIRED_USE="test? ( semantic-desktop )"

# blocker added due to compatibility issues and error during compile time
RDEPEND="
	${PYTHON_DEPS}
	>=dev-python/sip-4.14:=[${PYTHON_USEDEP}]

	$(add_kdebase_dep kdelibs 'opengl,semantic-desktop=')
	semantic-desktop? (
		$(add_kdebase_dep kdepimlibs 'semantic-desktop')
		>=dev-libs/soprano-2.9.0
	)
	aqua? ( >=dev-python/PyQt4-4.9.5[${PYTHON_USEDEP},dbus,declarative,script(+),sql,svg,webkit,aqua] )
	!aqua? ( >=dev-python/PyQt4-4.9.5[${PYTHON_USEDEP},dbus,declarative,script(+),sql,svg,webkit,X] )
"
DEPEND="${RDEPEND}
	sys-devel/libtool
"

pkg_setup() {
	kde4-base_pkg_setup

	have_python2=false

	scan_python_versions() {
		if [[ ${EPYTHON} == python2.* ]]; then
			have_python2=true
		fi
	}
	python_foreach_impl scan_python_versions

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

	sed -e 's/kpythonpluginfactory /kpython${PYTHON_SHORT_VERSION}pluginfactory /g' \
		-i kpythonpluginfactory/CMakeLists.txt || die

	if ${have_python2}; then
		mkdir -p "${WORKDIR}/wrapper" || die "failed to copy wrapper"
		cp "${FILESDIR}/kpythonpluginfactorywrapper.c-r1" "${WORKDIR}/wrapper/kpythonpluginfactorywrapper.c" || die "failed to copy wrapper"
	fi
	python_copy_sources

}

src_configure() {
	configuration() {
		pushd "${BUILD_DIR}" > /dev/null
		local mycmakeargs=(
			-DWITH_PolkitQt=OFF
			-DWITH_QScintilla=OFF
			$(cmake-utils_use_with semantic-desktop Soprano)
			$(cmake-utils_use_with semantic-desktop Nepomuk)
			$(cmake-utils_use_with semantic-desktop KdepimLibs)
			-DPYTHON_EXECUTABLE=${PYTHON}
			-DPYKDEUIC4_ALTINSTALL=TRUE
		)
		local CMAKE_BUILD_DIR=${S}_build-${PYTHON_ABI}
		kde4-base_src_configure
		popd > /dev/null
	}

	python_foreach_impl configuration
}

echo_and_run() {
	echo "$@"
	"$@"
}

src_compile() {
	compilation() {
		pushd "${BUILD_DIR}" > /dev/null
		local CMAKE_BUILD_DIR=${S}_build-${PYTHON_ABI}
		kde4-base_src_compile
		popd > /dev/null
	}
	python_foreach_impl compilation

	if ${have_python2}; then
		pushd "${WORKDIR}/wrapper" > /dev/null
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
		popd > /dev/null
	fi
}

src_install() {
	installation() {
		pushd "${BUILD_DIR}" > /dev/null
		emake DESTDIR="${D}" install
		popd > /dev/null

		mv "${ED}"/usr/bin/pykdeuic4-{${EPYTHON/python/},${EPYTHON}} || die
		python_optimize
	}
	python_foreach_impl installation

	dosym python-exec /usr/bin/pykdeuic4

	# As we don't call the eclass's src_install, we have to install the docs manually
	DOCS=("${S}"/{AUTHORS,NEWS,README})
	use doc && HTML_DOCS=("${S}/docs/html/")
	base_src_install_docs

	if ${have_python2}; then
		pushd "${WORKDIR}/wrapper" > /dev/null
		echo_and_run libtool --mode=install install kpythonpluginfactory.la "${ED}/usr/$(get_libdir)/kde4/kpythonpluginfactory.la"
		rm "${ED}/usr/$(get_libdir)/kde4/kpythonpluginfactory.la"
		popd > /dev/null
	fi
}

pkg_postinst() {
	kde4-base_pkg_postinst

	if use examples; then
		echo
		elog "PyKDE4 examples have been installed to"
		elog "${EPREFIX}/usr/share/apps/${PN}/examples"
		echo
	fi
}
