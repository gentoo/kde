# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit cmake-utils eutils

DESCRIPTION="Fast crawling desktop search engine with Qt4 GUI"
HOMEPAGE="http://www.vandenoever.info/software/strigi"
SRC_URI="http://www.vandenoever.info/software/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+clucene +dbus debug exif fam hyperestraier inotify log +qt4 test"
# IUSE="sqlite": fails to compile

COMMONDEPEND="
	dev-libs/libxml2
	virtual/libiconv
	clucene? ( >=dev-cpp/clucene-0.9.19 )
	dbus? ( sys-apps/dbus
		|| ( ( x11-libs/qt-dbus:4
			x11-libs/qt-gui:4 )
			=x11-libs/qt-4.3*:4 )
		)
	exif? ( media-gfx/exiv2 )
	fam? ( virtual/fam )
	hyperestraier? ( app-text/hyperestraier )
	log? ( >=dev-libs/log4cxx-0.9.7 )
	qt4? (
		|| ( ( x11-libs/qt-core:4
			x11-libs/qt-gui:4
			x11-libs/qt-dbus:4 )
			=x11-libs/qt-4.3*:4 )
		)
	!clucene? (
		!hyperestraier? (
		>=dev-cpp/clucene-0.9.19
	)
)"
#	sqlite? ( dev-db/sqlite:3 )"
DEPEND="${COMMONDEPEND}
	test? ( dev-util/cppunit )"
RDEPEND="${COMMONDEPEND}"

pkg_setup() {
	if use qt4 && ! use dbus; then
		if ( has_version "<x11-libs/qt-4.4.0_alpha:4" && !! built_with_use \
				x11-libs/qt:4 dbus ) || \
				( has_version "x11-libs/qt-gui:4" && ! built_with_use \
				x11-libs/qt-gui:4 dbus); then
			eerror "You are building Strigi with qt4 and dbus, but qt4 wasn't built with dbus support."
			eerror "Please re-emerge qt4 with dbus, or disable dbus in Strigi."
			die
		fi
	fi
}

src_compile() {
	# Strigi needs either expat or libxml2.
	# However libxml2 seems to be required in both cases, linking to 2 xml parsers
	# is just silly, so we forcefully disable linking to expat.
	# Enabled: POLLING (only reliable way to check for files changed.)

	mycmakeargs="${mycmakeargs}
		-DENABLE_EXPAT=OFF -DENABLE_POLLING=ON
		-DFORCE_DEPS=ON -DENABLE_CPPUNIT=OFF
		-DENABLE_REGENERATEXSD=OFF
		$(cmake-utils_use_enable clucene CLUCENE)
		$(cmake-utils_use_enable dbus DBUS)
		$(cmake-utils_use_enable exif EXIV2)
		$(cmake-utils_use_enable fam FAM)
		$(cmake-utils_use_enable hyperestraier HYPERESTRAIER)
		$(cmake-utils_use_enable inotify INOTIFY)
		$(cmake-utils_use_enable log LOG4CXX)
		$(cmake-utils_use_enable qt4 DBUS)
		$(cmake-utils_use_enable qt4 QT4)"
#		$(cmake-utils_use_enable sqlite SQLITE)"

	if ! use clucene && ! use hyperestraier; then # && ! use sqlite; then
		mycmakeargs="${mycmakeargs} -DENABLE_CLUCENE=ON"
	fi

	cmake-utils_src_compile
}

src_test() {
	mycmakeargs="${mycmakeargs} -DENABLE_CPPUNIT=ON"
	cmake-utils_src_compile

	pushd "${WORKDIR}/${PN}_build"
	ctest --extra-verbose || die "Tests failed."
	popd
}

pkg_postinst() {
	if ! use clucene && ! use hyperestraier; then # && ! use sqlite; then
			elog "Because you didn't enable any of the supported backends:"
			elog "clucene, hyperestraier and sqlite"
			elog "clucene support was silently installed."
			elog "If you prefer another backend, be sure to reinstall strigi"
			elog "and to enable that backend use flag"
	fi
}
