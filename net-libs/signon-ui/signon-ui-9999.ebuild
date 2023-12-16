# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils

if [[ ${PV} = *9999* ]] ; then
	EGIT_REPO_URI="https://gitlab.com/accounts-sso/signon-ui.git/"
	inherit git-r3
else
	COMMIT=4368bb77d9d1abc2978af514225ba4a42c29a646
	SRC_URI="https://gitlab.com/accounts-sso/${PN}/-/archive/${COMMIT}/${PN}-${COMMIT}.tar.bz2 -> ${P}.tar.bz2"
	S="${WORKDIR}/${PN}-${COMMIT}"
	KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"
fi

DESCRIPTION="Online accounts signon UI"
HOMEPAGE="https://gitlab.com/accounts-sso/signon-ui"

LICENSE="GPL-2 GPL-3"
SLOT="0"
IUSE="qt6 test"

RESTRICT="test"

COMMON_DEPEND="
	dev-libs/glib:2
	!qt6? (
		dev-qt/qtcore:5
		dev-qt/qtdbus:5
		dev-qt/qtdeclarative:5
		dev-qt/qtgui:5
		dev-qt/qtnetwork:5[ssl]
		dev-qt/qtwebengine:5
		dev-qt/qtwidgets:5
		>=net-libs/accounts-qt-1.16-r1[qt5]
		>=net-libs/signond-8.61-r1[qt5]
	)
	qt6? (
		dev-qt/qtbase:6[dbus,gui,network,ssl,widgets]
		dev-qt/qtdeclarative:6
		dev-qt/qtwebengine:6
		>=net-libs/accounts-qt-1.16-r1[qt6]
		>=net-libs/signond-8.61-r1[qt6]
	)
	net-libs/libproxy
	x11-libs/libnotify
"
RDEPEND="${COMMON_DEPEND}
	!qt6? ( dev-qt/qtwebchannel:5 )
	qt6? ( dev-qt/qtwebchannel:6 )
"
DEPEND="${COMMON_DEPEND}
	test? (
		!qt6? ( dev-qt/qttest:5 )
		qt6? ( dev-qt/qtbase:6[test] )
	)
"

PATCHES=(
	# thanks to openSUSE
	"${FILESDIR}/${PN}-0.15_p20171022-webengine-cachedir-path.patch"
	"${FILESDIR}/${PN}-0.15_p20171022-fix-username-field-reading.patch"
	# downstream
	"${FILESDIR}/${PN}-0.15_p20171022-drop-fno-rtti.patch"
	"${FILESDIR}/${PN}-0.15_p20171022-disable-tests.patch"
)

src_configure() {
	if use qt6; then
		eqmake6 PREFIX="${EPREFIX}"/usr
	else
		eqmake5 PREFIX="${EPREFIX}"/usr
	fi
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
