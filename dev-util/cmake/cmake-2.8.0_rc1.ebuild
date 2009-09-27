# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cmake/cmake-2.6.4-r2.ebuild,v 1.1 2009/07/28 16:30:34 arfrever Exp $

EAPI="2"

inherit elisp-common toolchain-funcs eutils versionator flag-o-matic cmake-utils

MY_PV="${PV/_/-}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Cross platform Make"
HOMEPAGE="http://www.cmake.org/"
SRC_URI="http://www.cmake.org/files/v$(get_version_component_range 1-2)/${MY_P}.tar.gz"

LICENSE="CMake"
KEYWORDS=""
SLOT="0"
IUSE="emacs qt4 vim-syntax"

DEPEND="
	>=net-misc/curl-7.16.4
	>=dev-libs/expat-2.0.1
	>=dev-libs/libxml2-2.6.28
	>=dev-libs/xmlrpc-c-1.06.27[curl]
	emacs? ( virtual/emacs )
	qt4? ( x11-libs/qt-gui:4 )
	vim-syntax? (
		|| (
			app-editors/vim
			app-editors/gvim
		)
	)
"
RDEPEND="${DEPEND}"

SITEFILE="50${PN}-gentoo.el"
VIMFILE="${PN}.vim"

S="${WORKDIR}/${MY_P}"

CMAKE_IN_SOURCE_BUILD=1

src_configure() {
	local qt_arg par_arg

	if [[ "$(gcc-major-version)" -eq "3" ]] ; then
		append-flags "-fno-stack-protector"
	fi

	bootstrap=0
	has_version ">=dev-util/cmake-2.6.1" || bootstrap=1
	if [[ ${bootstrap} = 0 ]]; then
		# Required version of CMake found, now test if it works
		cmake --version &> /dev/null
		if ! [[ $? = 0 ]]; then
			bootstrap=1
		fi
	fi

	if [[ ${bootstrap} = 1 ]]; then
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
	einfo "Please note that test \"58 - SimpleInstall-Stage2\" might fail."
	einfo "If any package installs with cmake, it means test failed but cmake work."
	emake test
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
