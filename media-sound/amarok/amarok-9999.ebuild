# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

# Translations are only in the tarballs, not the git repo
if [[ ${PV} != *9999* ]]; then
	KDE_LINGUAS="bg ca cs da de en_GB es et eu fi fr it ja km nb nds nl
	pa pl pt pt_BR ru sl sr sr@latin sv th tr uk wa zh_TW"
	SRC_URI="mirror://kde/unstable/${PN}/${PV}/src/${P}.tar.bz2"
	KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
else
	KDE_SCM="git"
	KEYWORDS=""
fi

KDE_REQUIRED="never"
inherit flag-o-matic kde4-base

DESCRIPTION="Advanced audio player based on KDE framework."
HOMEPAGE="http://amarok.kde.org/"

LICENSE="GPL-2"
SLOT="4"
IUSE="cdda daap debug +embedded ipod lastfm mp3tunes mtp opengl +player semantic-desktop +utils"

# Tests require gmock - http://code.google.com/p/gmock/
# It's not in the tree yet
RESTRICT="test"

# ipod requires gdk enabled and also gtk compiled in libgpod
COMMONDEPEND="
	>=media-libs/taglib-1.6.1[asf,mp4]
	>=media-libs/taglib-extras-1.0.1
	player? (
		app-crypt/qca:2
		>=app-misc/strigi-0.5.7[dbus,qt4]
		>=kde-base/kdelibs-${KDE_MINIMAL}[opengl?,semantic-desktop?]
		sys-libs/zlib
		>=virtual/mysql-5.1
		x11-libs/qt-script
		>=x11-libs/qtscriptgenerator-0.1.0
		cdda? (
			>=kde-base/libkcddb-${KDE_MINIMAL}
			>=kde-base/libkcompactdisc-${KDE_MINIMAL}
			>=kde-base/kdemultimedia-kioslaves-${KDE_MINIMAL}
		)
		embedded? (
			|| (
				>=dev-db/mysql-5.1.50-r3[embedded]
				>=dev-db/mariadb-5.1.50[embedded]
			)
		)
		ipod? ( >=media-libs/libgpod-0.7.0[gtk] )
		lastfm? ( >=media-libs/liblastfm-0.3.0 )
		mp3tunes? (
			dev-libs/glib:2
			dev-libs/libxml2
			dev-libs/openssl
			net-libs/loudmouth
			net-misc/curl
			x11-libs/qt-core[glib]
		)
		mtp? ( >=media-libs/libmtp-1.0.0 )
		opengl? ( virtual/opengl )
	)
	utils? (
		x11-libs/qt-core
		x11-libs/qt-dbus
	)
	!player? ( !utils? ( media-sound/amarok[player] ) )
"
DEPEND="${COMMONDEPEND}
	dev-util/automoc
	dev-util/pkgconfig
"
RDEPEND="${COMMONDEPEND}
	!media-sound/amarok-utils
	player? ( >=kde-base/phonon-kde-${KDE_MINIMAL} )
"

src_prepare() {
	if ! use player; then
		# Disable po processing
		sed -e "s:include(MacroOptionalAddSubdirectory)::" \
			-i "${S}/CMakeLists.txt" \
			|| die "Removing include of MacroOptionalAddSubdirectory failed."
		sed -e "s:macro_optional_add_subdirectory( po )::" \
			-i "${S}/CMakeLists.txt" \
			|| die "Removing include of MacroOptionalAddSubdirectory failed."
	fi

	kde4-base_src_prepare
}

src_configure() {
	# Append minimal-toc cflag for ppc64, see bug 280552 and 292707
	use ppc64 && append-flags -mminimal-toc

	if use player; then
		mycmakeargs=(
			-DWITH_PLAYER=ON
			-DWITH_Libgcrypt=OFF
			$(cmake-utils_use embedded WITH_MYSQL_EMBEDDED)
			$(cmake-utils_use_with ipod)
			$(cmake-utils_use_with ipod Gdk)
			$(cmake-utils_use_with lastfm LibLastFm)
			$(cmake-utils_use_with mtp)
			$(cmake-utils_use_with mp3tunes MP3Tunes)
		)
	else
		mycmakeargs=(
			-DWITH_PLAYER=OFF
		)
	fi

	mycmakeargs+=(
		$(cmake-utils_use_with utils UTILITIES)
	)
		# $(cmake-utils_use_with semantic-desktop Nepomuk)
		# $(cmake-utils_use_with semantic-desktop Soprano)

	kde4-base_src_configure
}

pkg_postinst() {
	kde4-base_pkg_postinst

	if use player; then

		if use daap; then
			echo
			elog "You have installed amarok with daap support."
			elog "You may be interested in installing www-servers/mongrel as well."
			echo
		fi

		if ! use embedded; then
			echo
			elog "You've disabled the amarok support for embedded mysql DBs."
			elog "You'll have to configure amarok to use an external db server."
			echo
			elog "Please read http://amaroklive.com/wiki/MySQL_Server for details on how"
			elog "to configure the external db and migrate your data from the embedded database."
			echo

			if has_version "dev-db/mysql[minimal]"; then
				elog "You built mysql with the minimal use flag, so it doesn't include the server."
				elog "You won't be able to use the local mysql installation to store your amarok collection."
				echo
			fi
		fi
	fi
}
