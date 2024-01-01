# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN=signon-plugin-oauth2
MY_PV=VERSION_${PV}
MY_P=${MY_PN}-${MY_PV}
inherit qmake-utils

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
# TODO: drop USE=qt5 and just have USE=qt6 to control which qt?
IUSE="+qt5 qt6 test"
REQUIRED_USE="|| ( qt5 qt6 )"
RESTRICT="!test? ( test )"

RDEPEND="
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtnetwork:5[ssl]
	)
	qt6? ( dev-qt/qtbase:6[network,ssl] )
	>=net-libs/signond-8.61-r1[qt5=,qt6=]
"
DEPEND="
	${RDEPEND}
	test? (
		qt5? ( dev-qt/qttest:5 )
	)
"

PATCHES=(
	# downstream patches
	"${FILESDIR}/${PN}-0.24-dont-install-tests.patch"
	"${FILESDIR}/${PN}-0.25-pkgconfig-libdir.patch"
	"${FILESDIR}/${PN}-0.25-drop-fno-rtti.patch"
)

src_prepare() {
	default
	sed -i "s|@LIBDIR@|$(get_libdir)|g" src/signon-oauth2plugin.pc || die
}

src_configure() {
	local myqmakeargs=(
		LIBDIR=/usr/$(get_libdir)
	)
	use test || myqmakeargs+=( CONFIG+=nomake_tests )

	if use qt6 ; then
		eqmake6 "${myqmakeargs[@]}"
	else
		eqmake5 "${myqmakeargs[@]}"
	fi
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
