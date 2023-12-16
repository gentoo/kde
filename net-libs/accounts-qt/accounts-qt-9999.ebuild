# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils multibuild

if [[ ${PV} = *9999* ]] ; then
	EGIT_REPO_URI="https://gitlab.com/nicolasfella/lib${PN}.git/"
	EGIT_BRANCH="qt6"
	inherit git-r3
else
	SRC_URI="https://gitlab.com/accounts-sso/lib${PN}/-/archive/VERSION_${PV}/lib${PN}-VERSION_${PV}.tar.gz -> ${P}a.tar.gz"
	S="${WORKDIR}/lib${PN}-VERSION_${PV}"
	KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc64 ~riscv ~x86"
fi

DESCRIPTION="Qt bindings for libaccounts-glib"
HOMEPAGE="https://accounts-sso.gitlab.io"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="doc +qt5 qt6 test"

# dbus problems
RESTRICT="test"

RDEPEND="
	dev-libs/glib:2
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtxml:5
	)
	qt6? ( dev-qt/qtbase:6[xml] )
	>=net-libs/libaccounts-glib-1.23:=
"
DEPEND="${RDEPEND}
	test? (
		qt5? ( dev-qt/qttest:5 )
		qt6? ( dev-qt/qtbase:6[test] )
	)
"
BDEPEND="
	doc? (
		app-doc/doxygen[dot]
		|| (
			dev-qt/qttools:6[assistant]
			dev-qt/qthelp:5
		)
	)
"

PATCHES=( "${FILESDIR}/${PN}-1.16-libdir.patch" )

pkg_setup() {
	MULTIBUILD_VARIANTS=( $(usev qt5) $(usev qt6) )
}

src_prepare() {
	default

	local qhelpgeneratorpath
	if has_version "dev-qt/qttools:6[assistant]"; then
		qhelpgeneratorpath="$(qt6_get_libdir)/qt6/libexec"
	elif has_version "dev-qt/qthelp:5"; then
		qhelpgeneratorpath="$(qt5_get_bindir)"
	else
		eerror "dev-qt/qttools:6[assistant] nor dev-qt/qthelp:5 available even though in deps(?)"
	fi

	sed -e "s|share/doc/\$\${PROJECT_NAME}|share/doc/${PF}|" \
		-i doc/doc.pri || die
	sed -e "/QHG_LOCATION/s|qhelpgenerator|${qhelpgeneratorpath}/&|" \
		-i doc/doxy.conf || die
	if ! use doc; then
		sed -e "/include( doc\/doc.pri )/d" -i ${PN}.pro || die
	fi
	if ! use test; then
		sed -e '/^SUBDIRS/s/tests//' \
			-i accounts-qt.pro || die "couldn't disable tests"
	fi
}

src_configure() {
	my_src_configure() {
		if [[ ${MULTIBUILD_VARIANT} == qt6 ]]; then
			eqmake6 PREFIX="${EPREFIX}"/usr LIBDIR=$(get_libdir)
		else
			eqmake5 PREFIX="${EPREFIX}"/usr LIBDIR=$(get_libdir)
		fi
	}

	multibuild_foreach_variant my_src_configure
}

src_compile() {
	multibuild_foreach_variant default
}

src_install() {
	multibuild_foreach_variant emake INSTALL_ROOT="${D}" install
}
