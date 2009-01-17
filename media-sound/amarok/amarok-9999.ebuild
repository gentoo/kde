# Copyright 1999-2008 Gentoo Foundation
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
SLOT="live"
IUSE="cdaudio daap debug ifp ipod mp3tunes mp4 mtp njb +semantic-desktop"

DEPEND=">=app-misc/strigi-0.5.7
	dev-db/sqlite:3
	|| ( >=dev-db/mysql-5.0[embedded]
		>=dev-db/mysql-community-5.0[embedded] )
	>=media-libs/taglib-1.5
	|| ( media-sound/phonon x11-libs/qt-phonon:4 )
	>=kde-base/kdelibs-${KDE_MINIMAL}[opengl?,semantic-desktop?]
	>=kde-base/plasma-workspace-${KDE_MINIMAL}
	x11-libs/qt-webkit:4
	cdaudio? ( >=kde-base/libkcompactdisc-${KDE_MINIMAL}
		>=kde-base/libkcddb-${KDE_MINIMAL} )
	ifp? ( media-libs/libifp )
	ipod? ( >=media-libs/libgpod-0.4.2 )
	mp3tunes? ( dev-libs/libxml2
		dev-libs/openssl
		net-libs/loudmouth
		net-misc/curl )
	mp4? ( media-libs/libmp4v2 )
	mtp? ( >=media-libs/libmtp-0.3.0 )
	njb? ( >=media-libs/libnjb-2.2.4 )
	semantic-desktop? ( dev-libs/soprano[sesame2] )"

RDEPEND="${DEPEND}
	app-arch/unzip
	daap? ( www-servers/mongrel )"

pkg_setup() {
	if use amd64 ; then
		ewarn
		ewarn "Compilation will fail if dev-db/mysql[-community] is built without -fPIC in your CFLAGS!"
		ewarn "Related bug: http://bugs.gentoo.org/show_bug.cgi?id=238487"
		ewarn
		ewarn "To fix this, and to avoid using -fPIC globally in your make.conf (which is not recommended),"
		ewarn "put the following into /etc/portage/env/dev-db/mysql (or mysql-community, depending on which you use;"
		ewarn "create dirs and the file if they don't exist):"
		ewarn
		ewarn "CFLAGS=\"${CFLAGS} -DPIC -fPIC\""
		ewarn "CXXFLAGS=\"${CXXFLAGS} -DPIC -fPIC\""
		ewarn
	fi
	kde4-base_pkg_setup
}

src_configure() {
	if use debug; then
		mycmakeargs="${mycmakeargs} -DCMAKE_BUILD_TYPE=debugfull"
	fi

	if ! use mp3tunes; then
		sed -e'/mp3tunes/ s:^:#DONOTWANT :' \
		-i "${S}"/src/services/CMakeLists.txt \
		|| die "Deactivating mp3tunes failed."
	fi

	# Remove superfluous QT_WEBKIT
	sed -e 's/ -DQT_WEBKIT//g' \
		-i "${S}"/src/scriptengine/generator/generator/CMakeLists.txt \
		|| die "Removing unnecessary -DQT_WEBKIT failed."

	mycmakeargs="${mycmakeargs}
		-DUSE_SYSTEM_SQLITE=ON
		$(cmake-utils_use_with cdaudio KdeMultimedia)
		$(cmake-utils_use_with ipod Ipod)
		$(cmake-utils_use_with ifp Ifp)
		$(cmake-utils_use_with mp4 Mp4v2)
		$(cmake-utils_use_with mtp Mtp)
		$(cmake-utils_use_with njb Njb)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)"
	kde4-base_src_configure
}
