# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

OPENGL_REQUIRED="optional"
KMNAME="extragear/multimedia"
inherit kde4-base

DESCRIPTION="Advanced audio player based on KDE framework."
HOMEPAGE="http://amarok.kde.org/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="2"
IUSE="cdaudio daap debug gtk ipod mp3tunes mtp +semantic-desktop +utils"

DEPEND="
	>=app-misc/strigi-0.5.7
	|| (
		>=dev-db/mysql-5.0[embedded]
		>=dev-db/mysql-community-5.0[embedded]
	)
	>=media-libs/taglib-1.5
	>=kde-base/kdelibs-${KDE_MINIMAL}[kdeprefix=,opengl?,semantic-desktop?]
	>=kde-base/phonon-kde-${KDE_MINIMAL}[kdeprefix=]
	>=kde-base/plasma-workspace-${KDE_MINIMAL}[kdeprefix=]
	sys-libs/zlib
	cdaudio? (
		>=kde-base/libkcddb-${KDE_MINIMAL}[kdeprefix=]
		>=kde-base/libkcompactdisc-${KDE_MINIMAL}[kdeprefix=]
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
	semantic-desktop? ( >=kde-base/nepomuk-${KDE_MINIMAL}[kdeprefix=] )
	utils? ( media-sound/amarok-utils )
"

pkg_setup() {
	if use amd64 ; then
		echo
		ewarn "Compilation will fail if dev-db/mysql[-community] is built without -fPIC in your CFLAGS!"
		ewarn "Related bug: http://bugs.gentoo.org/show_bug.cgi?id=238487"
		ewarn
		ewarn "To fix this, and to avoid using -fPIC globally in your make.conf (which is not recommended),"
		ewarn "put the following into /etc/portage/env/dev-db/mysql (or mysql-community, depending on which you use;"
		ewarn "create dirs and the file if they don't exist):"
		ewarn
		ewarn "CFLAGS=\"${CFLAGS} -DPIC -fPIC\""
		ewarn "CXXFLAGS=\"${CXXFLAGS} -DPIC -fPIC\""
		echo
	fi

	kde4-base_pkg_setup
}

src_configure() {
	# Remove superfluous QT_WEBKIT
	sed -e 's/ -DQT_WEBKIT//g' \
		-i "${S}"/src/scriptengine/generator/generator/CMakeLists.txt \
		|| die "Removing unnecessary -DQT_WEBKIT failed."

	mycmakeargs="${mycmakeargs}
		-DUSE_SYSTEM_SQLITE=ON
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
