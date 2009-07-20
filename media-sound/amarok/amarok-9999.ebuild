# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

OPENGL_REQUIRED="optional"
inherit git kde4-base

DESCRIPTION="Advanced audio player based on KDE framework."
HOMEPAGE="http://amarok.kde.org/"
EGIT_REPO_URI="git://gitorious.org/${PN}/${PN}.git"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="cdaudio daap debug ipod lastfm mp3tunes mtp +semantic-desktop"

# ipod requires gdk enabled and also gtk compiled in libgpod
DEPEND="
	>=app-misc/strigi-0.5.7
	|| (
		>=dev-db/mysql-5.0.76-r1[embedded,-minimal]
		>=dev-db/mysql-community-5.0.77-r1[embedded,-minimal]
	)
	>=media-libs/taglib-1.5
	>=media-libs/taglib-extras-0.1[kde]
	>=kde-base/kdelibs-${KDE_MINIMAL}[opengl?,semantic-desktop?]
	sys-libs/zlib
	>=x11-libs/qtscriptgenerator-0.1.0
	cdaudio? (
		>=kde-base/libkcddb-${KDE_MINIMAL}
		>=kde-base/libkcompactdisc-${KDE_MINIMAL}
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
	mtp? ( >=media-libs/libmtp-0.3.0 )
"
RDEPEND="${DEPEND}
	>=kde-base/phonon-kde-${KDE_MINIMAL}
	>=media-sound/amarok-utils-${PV}
	semantic-desktop? ( >=kde-base/nepomuk-${KDE_MINIMAL} )
"

PATCHES=( "${FILESDIR}/disable_bindings_test.patch" )

src_unpack() {
	git_src_unpack
}

src_configure() {
	# Workaround for problems related to libmysqld.so and collection plugin not
	# being found on some architectures when --as-needed is not used.
	append-ldflags -Wl,--as-needed

	mycmakeargs="${mycmakeargs}
		-DWITH_PLAYER=ON
		-DWITH_UTILITIES=OFF
		-DWITH_Libgcrypt=OFF
		$(cmake-utils_use_with ipod)
		$(cmake-utils_use_with ipod Gdk)
		$(cmake-utils_use_with lastfm LibLastFm)
		$(cmake-utils_use_with mtp)
		$(cmake-utils_use_with mp3tunes MP3Tunes)"
#		$(cmake-utils_use_with semantic-desktop Nepomuk)
#		$(cmake-utils_use_with semantic-desktop Soprano)"

	kde4-base_src_configure
}

pkg_postinst() {
	kde4-base_pkg_postinst

	if use daap; then
		echo
		elog "You have installed amarok with daap support."
		elog "You may be interested in installing www-servers/mongrel as well."
		echo
	fi
}
