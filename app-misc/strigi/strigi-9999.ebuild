# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/strigi/strigi-0.7.6.ebuild,v 1.1 2011/09/25 19:11:25 dilfridge Exp $

EAPI=4

if [[ "${PV}" != "9999" ]]; then
	SRC_URI="http://dev.gentoo.org/~dilfridge/distfiles/${P}.tar.xz"
	KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
else
	EGIT_REPO_URI="git://anongit.kde.org/strigi"
	GIT_ECLASS="git-2"
	EGIT_HAS_SUBMODULES="true"
	KEYWORDS=""
fi

inherit cmake-utils ${GIT_ECLASS}

DESCRIPTION="Fast crawling desktop search engine with Qt4 GUI"
HOMEPAGE="https://projects.kde.org/projects/kdesupport/strigi/strigi"

LICENSE="GPL-2"
SLOT="0"
IUSE="clucene +dbus debug exif fam ffmpeg hyperestraier inotify log +qt4 test"

COMMONDEPEND="
	app-arch/bzip2:0
	dev-libs/libxml2:2
	sys-libs/zlib:0
	virtual/libiconv
	clucene? ( >=dev-cpp/clucene-0.9.21[-debug] )
	dbus? (
		sys-apps/dbus
		qt4? ( x11-libs/qt-dbus:4 )
	)
	exif? ( >=media-gfx/exiv2-0.17 )
	fam? ( virtual/fam )
	ffmpeg? ( virtual/ffmpeg )
	hyperestraier? ( app-text/hyperestraier )
	log? ( >=dev-libs/log4cxx-0.10.0 )
	qt4? (
		x11-libs/qt-core:4
		x11-libs/qt-gui:4
	)
"
DEPEND="${COMMONDEPEND}
	test? ( dev-util/cppunit )"
RDEPEND="${COMMONDEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-0.7.5-no-qt4.patch"
)

src_configure() {
	# Enabled: POLLING (only reliable way to check for files changed.)
	# Disabled: xine - recommended upstream to keep it this way
	mycmakeargs=(
		-DENABLE_POLLING=ON
		-DFORCE_DEPS=ON
		-DENABLE_CPPUNIT=OFF
		-DENABLE_REGENERATEXSD=OFF
		-DENABLE_XINE=OFF
		$(cmake-utils_use_enable clucene)
		$(cmake-utils_use_enable dbus)
		$(cmake-utils_use_enable exif EXIV2)
		$(cmake-utils_use_enable fam)
		$(cmake-utils_use_enable ffmpeg)
		$(cmake-utils_use_enable hyperestraier)
		$(cmake-utils_use_enable inotify)
		$(cmake-utils_use_enable log LOG4CXX)
		$(cmake-utils_use_enable qt4)
		$(cmake-utils_use_enable test CPPUNIT)
	)

	if use qt4; then
		mycmakeargs+=(-DENABLE_DBUS=ON)
	fi

	cmake-utils_src_configure
}

pkg_postinst() {
	if ! use clucene && ! use hyperestraier; then
		echo
		elog "Because you didn't enable either of the available backends:"
		elog "clucene or hyperestraier, strigi may not be functional."
		elog "If you intend to use standalone strigi indexer (not needed for KDE),"
		elog "be sure to reinstall app-misc/strigi with either clucene (recommended)"
		elog "or hyperestraier (unreliable) USE flag enabled."
		echo
	fi
}
