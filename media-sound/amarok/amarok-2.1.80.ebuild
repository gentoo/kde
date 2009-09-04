# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/amarok/amarok-2.1.1.ebuild,v 1.2 2009/07/22 16:11:11 ssuominen Exp $

EAPI="2"

KDE_LINGUAS="bg ca cs da de el en_GB es et eu fr gl he is it ja km ku lt lv nb
nds nl nn pa pl pt pt_BR ro ru sl sv th tr uk wa zh_CN zh_TW"
OPENGL_REQUIRED="optional"
KMNAME="extragear/multimedia"
inherit kde4-base

DESCRIPTION="Advanced audio player based on KDE framework."
HOMEPAGE="http://amarok.kde.org/"
SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="cdda daap debug ipod mp3tunes mtp +semantic-desktop"

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
	cdda? (
		>=kde-base/libkcddb-${KDE_MINIMAL}
		>=kde-base/libkcompactdisc-${KDE_MINIMAL}
	)
	ipod? (
		>=media-libs/libgpod-0.7.0[gtk]
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
	>=kde-base/phonon-kde-${KDE_MINIMAL}
	>=media-sound/amarok-utils-${PV}
	semantic-desktop? ( >=kde-base/nepomuk-${KDE_MINIMAL} )
"

PATCHES=( "${FILESDIR}/disable_bindings_test.patch" )

src_configure() {
	# Workaround for problems related to libmysqld.so and collection plugin not
	# being found on some architectures when --as-needed is not used.
	append-ldflags -Wl,--as-needed

	mycmakeargs="${mycmakeargs}
		-DWITH_PLAYER=ON
		-DWITH_UTILITIES=OFF
		-DWITH_Libgcrypt=OFF
		$(cmake-utils_use_with ipod Ipod)
		$(cmake-utils_use_with ipod Gdk)
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
		elog "You may be interested in installing www-servers/mongrel as well."
		echo
	fi
}
