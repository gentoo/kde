# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

QT_MINIMAL="4.7.0"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="http://download.tomahawk-player.org/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
else
	GIT_ECLASS="git-2"
	EGIT_REPO_URI="git://github.com/tomahawk-player/tomahawk.git"
	KEYWORDS=""
fi

inherit cmake-utils qt4-r2 ${GIT_ECLASS}

DESCRIPTION="Qt playdar social music player."
HOMEPAGE="http://tomahawk-player.org/"

LICENSE="GPL-3 BSD"
SLOT="0"
IUSE="debug fftw libsamplerate"

# Broken -X (Headless mode) by upstream
# X? (
#	>=x11-libs/qt-gui-${QT_MINIMAL}:4
#	>=x11-libs/qt-webkit-${QT_MINIMAL}:4
#)

DEPEND="
	>=dev-cpp/clucene-2.3.3.4
	>=dev-libs/boost-1.41
	>=dev-libs/qjson-0.7.1
	>=media-libs/libechonest-1.1.8
	media-libs/phonon
	media-libs/taglib
	net-libs/jreen
	net-libs/qtweetlib
	>=x11-libs/qt-core-${QT_MINIMAL}:4
	>=x11-libs/qt-gui-${QT_MINIMAL}:4
	>=x11-libs/qt-sql-${QT_MINIMAL}:4[sqlite]
	>=x11-libs/qt-webkit-${QT_MINIMAL}:4
	>=x11-libs/qt-xmlpatterns-${QT_MINIMAL}:4
	fftw? ( sci-libs/fftw:3.0 )
	libsamplerate? ( media-libs/libsamplerate )
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-clucene.patch"
)

src_configure() {
	mycmakeargs=(
		-DINTERNAL_JREEN=OFF
		-DINTERNAL_QTWEETLIB=OFF
	)
	cmake-utils_src_configure
}

src_compile() {
	# with as-needed compile will fail
	append-ldflags $(no-as-needed)

	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}

pkg_postinst() {
	echo
	elog "Information on how to get more resolvers for ${PN}"
	elog "is available at ${HOMEPAGE}resolvers"
	echo
}
