# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils multibuild

if [[ ${PV} = *9999* ]] ; then
	EGIT_REPO_URI="https://gitlab.com/accounts-sso/accounts-qml-module.git/"
	inherit git-r3
else
	SRC_URI="https://gitlab.com/accounts-sso/${PN}-module/-/archive/VERSION_${PV}/${PN}-module-VERSION_${PV}.tar.gz
		https://dev.gentoo.org/~asturm/distfiles/${P}-patches-1.tar.xz"
	S="${WORKDIR}/${PN}-module-VERSION_${PV}"
	KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc64 ~riscv ~x86"
fi

DESCRIPTION="QML bindings for accounts-qt and signond"
HOMEPAGE="https://accounts-sso.gitlab.io/"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="doc +qt5 qt6 test"

# dbus problems
RESTRICT="test"

RDEPEND="
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtdeclarative:5
	)
	qt6? (
		dev-qt/qtbase:6
		dev-qt/qtdeclarative:6
	)
	>=net-libs/accounts-qt-1.16-r1[qt5?,qt6?]
	>=net-libs/signond-8.61-r1[qt5?,qt6?]
"
DEPEND="${RDEPEND}
	test? (
		qt5? (
			dev-qt/qtgui:5
			dev-qt/qttest:5
		)
		qt6? ( dev-qt/qtbase:6[gui,test] )
	)
"
BDEPEND="
	doc? (
		app-doc/doxygen
		|| (
			( dev-qt/qttools:6[assistant,qdoc] )
			(
				dev-qt/qdoc:5
				dev-qt/qthelp:5
			)
		)
	)
"

DOCS=( README.md )

pkg_setup() {
	MULTIBUILD_VARIANTS=( $(usev qt5) $(usev qt6) )
}

src_prepare() {
	default
	rm -v .gitignore doc/html/.gitignore || die
}

src_configure() {
	my_src_configure() {
		local myqmakeargs=(
			CONFIG+=no_docs \
			PREFIX="${EPREFIX}"/usr
		)

		if [[ ${MULTIBUILD_VARIANT} == qt6 ]]; then
			eqmake6 "${myqmakeargs[@]}"
		else
			eqmake5 "${myqmakeargs[@]}"
		fi
	}

	multibuild_foreach_variant my_src_configure
}

src_compile() {
	multibuild_foreach_variant default
	if use doc; then
		local qtanybindir
		if has_version "dev-qt/qttools:6[qdoc]"; then
			qtanybindir="$(qt6_get_libdir)"
		elif has_version "dev-qt/qdoc:5"; then
			qtanybindir="$(qt5_get_bindir)"
		else
			eerror "dev-qt/qttools:6[qdoc] nor dev-qt/qdoc:5 available even though in deps(?)"
		fi
		${qtanybindir}/qdoc doc/accounts-qml-module.qdocconf || die
	fi
}

src_install() {
	multibuild_foreach_variant emake INSTALL_ROOT="${D}" install_subtargets
	use doc && local HTML_DOCS=( doc/html )
	einstalldocs
}
