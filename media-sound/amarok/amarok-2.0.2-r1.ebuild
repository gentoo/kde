# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/amarok/amarok-2.0.1.1.ebuild,v 1.12 2009/03/16 10:24:20 scarabeus Exp $

EAPI="2"

KDE_LINGUAS="ar be bg ca cs csb da de el eo es et eu fi fr ga gl he is it ja km
	ko ku lt lv nb nds ne nl nn oc pa pl pt pt_BR ro ru se si sk sl sv th tr uk zh_CN zh_TW"
OPENGL_REQUIRED="optional"
inherit kde4-base

DESCRIPTION="Advanced audio player based on KDE framework."
HOMEPAGE="http://amarok.kde.org/"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="2"
IUSE="cdaudio daap debug ifp ipod mp3tunes mp4 mtp njb +semantic-desktop"
SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"

DEPEND="
	>=app-misc/strigi-0.5.7
	|| (
		>=dev-db/mysql-5.0[embedded,-minimal]
		>=dev-db/mysql-community-5.0[embedded,-minimal]
	)
	>=media-libs/taglib-1.5
	>=kde-base/kdelibs-${KDE_MINIMAL}[opengl?,semantic-desktop?]
	>=kde-base/phonon-kde-${KDE_MINIMAL}
	>=kde-base/plasma-workspace-${KDE_MINIMAL}
	cdaudio? (
		>=kde-base/libkcompactdisc-${KDE_MINIMAL}
		>=kde-base/libkcddb-${KDE_MINIMAL}
	)
	ifp? ( media-libs/libifp )
	ipod? ( >=media-libs/libgpod-0.7.0 )
	mp3tunes? (
		dev-libs/libxml2
		dev-libs/openssl
		net-libs/loudmouth
		net-misc/curl
	)
	mp4? ( media-libs/libmp4v2 )
	mtp? ( >=media-libs/libmtp-0.3.0 )
	njb? ( >=media-libs/libnjb-2.2.4 )
"

RDEPEND="${DEPEND}
	app-arch/unzip
	daap? ( www-servers/mongrel )"

PATCHES=( "${FILESDIR}/${PN}-ipod.patch" )

src_configure() {
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
