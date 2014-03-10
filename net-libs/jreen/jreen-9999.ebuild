# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/euroelessar/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
else
	GIT_ECLASS="git-r3"
	EGIT_REPO_URI=( "git://github.com/euroelessar/${PN}" )
	KEYWORDS=""
fi

inherit cmake-utils ${GIT_ECLASS}

DESCRIPTION="Qt XMPP library"
HOMEPAGE="https://github.com/euroelessar/jreen"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug +qt4 qt5"

REQUIRED_USE="^^ ( qt4 qt5 )"

DEPEND="
	media-libs/speex
	>=net-dns/libidn-1.20
	net-libs/libgsasl
	qt4? (
		>=app-crypt/qca-2.0.3[qt4(+)]
		>=dev-qt/qtcore-4.6.0:4
		>=dev-qt/qtgui-4.6.0:4
	)
	qt5? (
		=app-crypt/qca-9999[qt5]
		dev-qt/qtcore:5
		dev-qt/qtnetwork:5
	)
"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS ChangeLog README )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use qt4 JREEN_FORCE_QT4)
	)

	cmake-utils_src_configure
}
