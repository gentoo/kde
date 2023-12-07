# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils multibuild

if [[ ${PV} = *9999* ]] ; then
	EGIT_REPO_URI="https://gitlab.com/nicolasfella/signond.git/"
	EGIT_BRANCH="qt6"
	inherit git-r3
else
	SRC_URI="https://gitlab.com/accounts-sso/${PN}/-/archive/VERSION_${PV}/${PN}-VERSION_${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-VERSION_${PV}"
	KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc64 ~riscv ~x86"
fi

DESCRIPTION="Signon daemon for libaccounts-glib"
HOMEPAGE="https://gitlab.com/accounts-sso"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="doc +qt5 qt6 test"

# tests are brittle; they all pass when stars align, bug 727666
RESTRICT="test !test? ( test )"

RDEPEND="
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtdbus:5
		dev-qt/qtgui:5
		dev-qt/qtnetwork:5
		dev-qt/qtsql:5
	)
	qt6? ( dev-qt/qtbase:6[dbus,gui,network,sql] )
	net-libs/libproxy
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

PATCHES=(
	"${FILESDIR}/${PN}-8.60-buildsystem.patch"
	"${FILESDIR}/${PN}-8.60-unused-dep.patch" # bug 727346
	"${FILESDIR}/${PN}-8.61-consistent-paths.patch" # bug 701142
)

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

	sed -e "/QHG_LOCATION/s|qhelpgenerator|${qhelpgeneratorpath}/&|" \
		-i {lib/plugins/,lib/SignOn/,}doc/doxy.conf || die

	# install docs to correct location
	sed -e "s|share/doc/\$\${PROJECT_NAME}|share/doc/${PF}|" \
		-i doc/doc.pri || die
	sed -e "/^documentation.path = /c\documentation.path = \$\${INSTALL_PREFIX}/share/doc/${PF}/\$\${TARGET}/" \
		-i lib/plugins/doc/doc.pri || die
	sed -e "/^documentation.path = /c\documentation.path = \$\${INSTALL_PREFIX}/share/doc/${PF}/libsignon-qt/" \
		-i lib/SignOn/doc/doc.pri || die

	use doc || sed -e "/include(\s*doc\/doc.pri\s*)/d" \
		-i signon.pro lib/SignOn/SignOn.pro lib/plugins/plugins.pro || die

	use test || sed -e '/^SUBDIRS/s/tests//' \
		-i signon.pro || die "couldn't disable tests"
}

src_configure() {
	my_src_configure() {
		local myqmakeargs=(
			PREFIX="${EPREFIX}"/usr
			LIBDIR=$(get_libdir)
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
}

src_install() {
	multibuild_foreach_variant emake INSTALL_ROOT="${D}" install
}
