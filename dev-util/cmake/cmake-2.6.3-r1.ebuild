# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cmake/cmake-2.6.3.ebuild,v 1.1 2009/03/01 13:13:40 scarabeus Exp $

EAPI="2"

inherit elisp-common toolchain-funcs eutils versionator flag-o-matic cmake-utils

MY_PV="${PV/rc/RC-}"
MY_P="${PN}-$(replace_version_separator 3 - ${MY_PV})"

DESCRIPTION="Cross platform Make"
HOMEPAGE="http://www.cmake.org/"
SRC_URI="http://www.cmake.org/files/v$(get_version_component_range 1-2)/${MY_P}.tar.gz"

LICENSE="CMake"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="emacs qt4 vim-syntax"

DEPEND=">=net-misc/curl-7.16.4
	>=dev-libs/expat-2.0.1
	>=dev-libs/libxml2-2.6.28
	>=dev-libs/xmlrpc-c-1.06.09[curl]
	emacs? ( virtual/emacs )
	qt4? ( || ( ( x11-libs/qt-core:4
			x11-libs/qt-gui:4 )
		>=x11-libs/qt-4.3:4 ) )
	vim-syntax? ( || (
		app-editors/vim
		app-editors/gvim ) )"
RDEPEND="${DEPEND}"

SITEFILE="50${PN}-gentoo.el"
VIMFILE="${PN}.vim"

S="${WORKDIR}/${MY_P}"

CMAKE_IN_SOURCE_BUILD=1
src_prepare() {
	epatch "${FILESDIR}/${PN}-FindPythonLibs.patch"
	epatch "${FILESDIR}/${PN}-FindPythonInterp.patch"
}

src_configure() {
	local qt_arg par_arg

	if [[ "$(gcc-major-version)" -eq "3" ]] ; then
		append-flags "-fno-stack-protector"
	fi

	if ! has_version ">=dev-util/cmake-2.4.1" ; then
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
			--prefix=/usr \
			--docdir=/share/doc/${PF} \
			--datadir=/share/${PN} \
			--mandir=/share/man \
			"$qt_arg" \
			"$par_arg" || die "./bootstrap failed"
	else
		# this is way much faster so we should preffer it if some cmake is
		# around.
		use qt4 && qt_arg="ON" || qt_arg="OFF"
		mycmakeargs="-DCMAKE_USE_SYSTEM_LIBRARIES=ON
			-DCMAKE_DOC_DIR=/share/doc/${PF}
			-DCMAKE_MAN_DIR=/share/man
			-DCMAKE_DATA_DIR=/share/${PN}
			-DBUILD_CursesDialog=ON
			-DBUILD_QtDialog=${qt_arg}"
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
	emake test || \
		einfo "note test failure on qtwrapping was expected - nature of portage rather than a true failure"
}

src_install() {
	cmake-utils_src_install
	if use emacs; then
		elisp-install ${PN} Docs/cmake-mode.el Docs/cmake-mode.elc || die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/syntax
		doins "${S}"/Docs/cmake-syntax.vim

		insinto /usr/share/vim/vimfiles/indent
		doins "${S}"/Docs/cmake-indent.vim

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
