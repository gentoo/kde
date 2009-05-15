# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

OPENGL_REQUIRED="optional"
KMNAME="extragear/multimedia"
inherit flag-o-matic kde4-base

DESCRIPTION="Advanced audio player based on KDE framework."
HOMEPAGE="http://amarok.kde.org/"
SRC_URI="mirror://kde/unstable/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="2"
IUSE="cdaudio daap debug gtk ipod mp3tunes mtp +semantic-desktop"

DEPEND="
	>=app-misc/strigi-0.5.7
	|| (
		>=dev-db/mysql-5.0.76-r1[embedded,-minimal]
		>=dev-db/mysql-community-5.0.77-r1[embedded,-minimal]
	)
	>=media-libs/taglib-1.5
	>=media-libs/taglib-extras-0.1[kde]
	>=kde-base/kdelibs-${KDE_MINIMAL}[opengl?,semantic-desktop?]
	>=kde-base/phonon-kde-${KDE_MINIMAL}
	>=kde-base/plasma-workspace-${KDE_MINIMAL}
	sys-libs/zlib
	>=x11-libs/qtscriptgenerator-0.1.0
	cdaudio? (
		>=kde-base/libkcddb-${KDE_MINIMAL}
		>=kde-base/libkcompactdisc-${KDE_MINIMAL}
	)
	ipod? (
		>=media-libs/libgpod-0.7.0
		gtk? ( x11-libs/gtk+:2 )
	)
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
	media-sound/amarok-utils
	semantic-desktop? ( >=kde-base/nepomuk-${KDE_MINIMAL} )
"

src_prepare() {
	kde4-base_src_prepare

	append-flags -I${KDEDIR}
	append-ldflags -L${KDEDIR}/$(get_libdir) -Wl,--as-needed
	epatch "${FILESDIR}/disable_bindings_test.patch"
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DWITH_PLAYER=ON
		-DWITH_UTILITIES=OFF
		-DWITH_Libgcrypt=OFF
		$(cmake-utils_use_with ipod Ipod)
		$(cmake-utils_use_with gtk Gdk)
		$(cmake-utils_use_with mtp Mtp)
		$(cmake-utils_use_with mp3tunes MP3TUNES)"
#		$(cmake-utils_use_with semantic-desktop Nepomuk)
#		$(cmake-utils_use_with semantic-desktop Soprano)"

	kde4-base_src_configure
}

pkg_postinst() {
	kde4-base_pkg_postinst

	if use daap; then
		echo
		elog "You have installed amarok with daap support."
		elog "You may be insterested in installing www-servers/mongrel as well."
		echo
	fi
}
