# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

EAPI="3"

inherit elisp-common toolchain-funcs eutils versionator flag-o-matic base cmake-utils

MY_P="${PN}-$(replace_version_separator 3 - ${MY_PV})"

DESCRIPTION="Cross platform Make"
HOMEPAGE="http://www.cmake.org/"
SRC_URI="http://www.cmake.org/files/v$(get_version_component_range 1-2)/${MY_P}.tar.gz"

LICENSE="CMake"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~sparc-fbsd ~x86-fbsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
SLOT="0"
IUSE="emacs ncurses qt4 vim-syntax"

DEPEND="
	>=net-misc/curl-7.20.0-r1[ssl]
	>=dev-libs/expat-2.0.1
	sys-libs/zlib
	ncurses? ( sys-libs/ncurses )
	qt4? ( x11-libs/qt-gui:4 )
"
RDEPEND="${DEPEND}
	emacs? ( virtual/emacs )
	vim-syntax? (
		|| (
			app-editors/vim
			app-editors/gvim
		)
	)
"

SITEFILE="50${PN}-gentoo.el"
VIMFILE="${PN}.vim"

S="${WORKDIR}/${MY_P}"

CMAKE_IN_SOURCE_BUILD=1

PATCHES=(
	"${FILESDIR}"/${PN}-FindPythonLibs.patch
	"${FILESDIR}"/${PN}-FindPythonInterp.patch
	"${FILESDIR}"/${PN}-2.6.0-interix.patch
	"${FILESDIR}"/${PN}-2.6.3-darwin-bundle.patch
	"${FILESDIR}"/${PN}-2.6.3-no-duplicates-in-rpath.patch
	"${FILESDIR}"/${PN}-2.6.3-fix_broken_lfs_on_aix.patch
	"${FILESDIR}"/${PN}-2.8.0-darwin-default-install_name.patch
	"${FILESDIR}"/${PN}-2.8.0-darwin-no-app-with-qt.patch
	"${FILESDIR}"/${PN}-2.8.1-more-no_host_paths.patch
	"${FILESDIR}"/${PN}-2.8.1-FindBoost.patch
	"${FILESDIR}"/${PN}-2.8.1-libform.patch
)

src_prepare() {
	base_src_prepare

	# Add gcc libs to the default link paths
	sed -i \
		-e "s|@GENTOO_PORTAGE_GCCLIBDIR@|${EPREFIX}/usr/${CHOST}/lib|g" \
		-e "s|@GENTOO_PORTAGE_EPREFIX@|${EPREFIX}/|g" \
		Modules/Platform/{UnixPaths,Darwin}.cmake || die "sed failed"
}

src_configure() {
	if [[ "$(gcc-major-version)" -eq "3" ]] ; then
		append-flags "-fno-stack-protector"
	fi

	bootstrap=0
	has_version ">=dev-util/cmake-2.6.1" || bootstrap=1
	if [[ ${bootstrap} = 0 ]]; then
		# Required version of CMake found, now test if it works
		cmake --version &> /dev/null || bootstrap=1
	fi

	if [[ ${bootstrap} = 1 ]]; then
		local qt_arg par_arg
		tc-export CC CXX LD

		if use qt4; then
			qt_arg="--qt-gui"
		else
			qt_arg="--no-qt-gui"
		fi

		echo $MAKEOPTS | egrep -o '(\-j|\-\-jobs)(=?|[[:space:]]*)[[:digit:]]+' > /dev/null
		if [ $? -eq 0 ]; then
			par_arg=$(echo $MAKEOPTS | egrep -o '(\-j|\-\-jobs)(=?|[[:space:]]*)[[:digit:]]+' | egrep -o '[[:digit:]]+')
			par_arg="--parallel=${par_arg}"
		else
			par_arg="--parallel=1"
		fi

		./bootstrap \
			--system-libs \
			--prefix="${EPREFIX}"/usr \
			--docdir=/share/doc/${PF} \
			--datadir=/share/${PN} \
			--mandir=/share/man \
			"$qt_arg" \
			"$par_arg" || die "./bootstrap failed"
	else
		# this is way much faster so we should prefer it if some cmake is
		# around.
		local mycmakeargs=(
			-DCMAKE_USE_SYSTEM_LIBRARIES=ON
			-DCMAKE_INSTALL_PREFIX="${EPREFIX}"/usr
			-DCMAKE_DOC_DIR=/share/doc/${PF}
			-DCMAKE_MAN_DIR=/share/man
			-DCMAKE_DATA_DIR=/share/${PN}
			$(cmake-utils_use_build ncurses CursesDialog)
			$(cmake-utils_use_build qt4 QtDialog)
		)
		cmake-utils_src_configure
	fi
}

src_compile() {
	cmake-utils_src_compile
	if use emacs; then
		elisp-compile Docs/cmake-mode.el || die "elisp compile failed"
	fi
}

src_test() {
	emake test || die "Tests failed"
}

src_install() {
	cmake-utils_src_install
	if use emacs; then
		elisp-install ${PN} Docs/cmake-mode.el Docs/cmake-mode.elc || die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/syntax
		doins Docs/cmake-syntax.vim

		insinto /usr/share/vim/vimfiles/indent
		doins Docs/cmake-indent.vim

		insinto /usr/share/vim/vimfiles/ftdetect
		doins "${FILESDIR}/${VIMFILE}"
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
