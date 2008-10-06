# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

NEED_KDE=":4.1"
inherit kde4-base

# Install to KDEDIR rather than /usr, to slot properly.
PREFIX="${KDEDIR}"

DESCRIPTION="Advanced audio player based on KDE framework."
HOMEPAGE="http://amarok.kde.org/"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4.1"
IUSE="cdaudio daap debug ifp ipod mp3tunes mp4 mtp mysql njb opengl visualization"
SRC_URI="mirror://kde/unstable/${PN}/${PV}/src/${P}.tar.bz2"

# daap are automagic

DEPEND="
	>=app-misc/strigi-0.5.7
	dev-db/sqlite:3
	kde-base/kdelibs:${SLOT}
	kde-base/libplasma:${SLOT}
	>=media-libs/taglib-1.5
	|| ( x11-libs/qt-phonon:4 media-sound/phonon )
	x11-libs/qt-webkit:4
	cdaudio? ( kde-base/libkcddb:${SLOT}
		kde-base/libkcompactdisc:${SLOT} )
	ifp? ( media-libs/libifp )
	ipod? ( >=media-libs/libgpod-0.4.2 )
	mp3tunes? ( net-misc/curl
		    dev-libs/libxml2 )
	mp4? ( media-libs/libmp4v2 )
	mtp? ( >=media-libs/libmtp-0.1.1 )
	mysql? ( >=virtual/mysql-4.0 )
	njb? ( >=media-libs/libnjb-2.2.4 )
	opengl? ( virtual/opengl )
	visualization? ( media-libs/libsdl
		=media-plugins/libvisual-plugins-0.4* )
	"
RDEPEND="${DEPEND}
	app-arch/unzip
	daap? ( www-servers/mongrel )
	"

src_configure() {
	if use debug; then
		mycmakeargs="${mycmakeargs} -DCMAKE_BUILD_TYPE=debugfull"
	fi
	mycmakeargs="${mycmakeargs}
		-DCMAKE_INSTALL_PREFIX=${PREFIX}
		-DUSE_SYSTEM_SQLITE=ON
		$(cmake-utils_use_with cdaudio KdeMultimedia)
		$(cmake-utils_use_with ifp Ifp)
		$(cmake-utils_use_with ipod Ipod)
		$(cmake-utils_use_with mp4 Mp4v2)
		$(cmake-utils_use_with mtp Mtp)
		$(cmake-utils_use_with mysql MySQL)
		$(cmake-utils_use_with njb Njb)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with visualization Libvisual)
	"
	kde4-base_src_configure
}
