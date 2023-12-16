# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN=signon-plugin-oauth2
MY_PV=VERSION_${PV}
MY_P=${MY_PN}-${MY_PV}
inherit qmake-utils multibuild

if [[ ${PV} = *9999* ]] ; then
	EGIT_REPO_URI="https://gitlab.com/nicolasfella/${MY_PN}.git/"
	EGIT_BRANCH="qt6"
	inherit git-r3
else
	SRC_URI="https://gitlab.com/accounts-sso/${MY_PN}/-/archive/${MY_PV}/${MY_P}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${MY_P}"
	KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc64 ~riscv ~x86"
fi

DESCRIPTION="OAuth2 plugin for Signon daemon"
HOMEPAGE="https://gitlab.com/accounts-sso/signon-plugin-oauth2"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="+qt5 qt6 test"
RESTRICT="!test? ( test )"

RDEPEND="
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtnetwork:5[ssl]
	)
	qt6? ( dev-qt/qtbase:6[network,ssl] )
	>=net-libs/signond-8.61-r1[qt5?,qt6?]
"
DEPEND="${RDEPEND}
	test? (
		qt5? ( dev-qt/qttest:5 )
		qt6? ( dev-qt/qtbase:6[test] )
	)
"

PATCHES=(
	# downstream patches
	"${FILESDIR}/${PN}-0.24-dont-install-tests.patch"
	"${FILESDIR}/${PN}-0.25-pkgconfig-libdir.patch"
	"${FILESDIR}/${PN}-0.25-drop-fno-rtti.patch"
)

pkg_setup() {
	MULTIBUILD_VARIANTS=( $(usev qt5) $(usev qt6) )
}

src_prepare() {
	default
	sed -i "s|@LIBDIR@|$(get_libdir)|g" src/signon-oauth2plugin.pc || die
}

src_configure() {
	my_src_configure() {
		local myqmakeargs=(
			LIBDIR=/usr/$(get_libdir)
		)
		use test || myqmakeargs+=( CONFIG+=nomake_tests )

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
