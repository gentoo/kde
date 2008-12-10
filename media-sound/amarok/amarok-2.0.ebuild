# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

NEED_KDE="4.1"
OPENGL_REQUIRED="optional"
inherit kde4-base

DESCRIPTION="Advanced audio player based on KDE framework."
HOMEPAGE="http://amarok.kde.org/"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="2"
IUSE="cdaudio daap debug ifp ipod mp3tunes mp4 mtp njb +semantic-desktop"
SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"

DEPEND=">=app-misc/strigi-0.5.7
	|| (
		>=dev-db/mysql-5.0[embedded]
		>=dev-db/mysql-community-5.0[embedded]
	)
	>=media-libs/taglib-1.5
	|| ( media-sound/phonon x11-libs/qt-phonon:4 )
	>=kde-base/kdelibs-${NEED_KDE}[opengl?,semantic-desktop?]
	>=kde-base/plasma-workspace-${NEED_KDE}
	x11-libs/qt-webkit:4
	cdaudio? (
		>=kde-base/libkcompactdisc-${NEED_KDE}
		>=kde-base/libkcddb-${NEED_KDE}
	)
	ifp? ( media-libs/libifp )
	ipod? ( >=media-libs/libgpod-0.4.2 )
	mp3tunes? (
		dev-libs/libxml2
		dev-libs/openssl
		net-libs/loudmouth
		net-misc/curl
	)
	mp4? ( media-libs/libmp4v2 )
	mtp? ( >=media-libs/libmtp-0.3.0 )
	njb? ( >=media-libs/libnjb-2.2.4 )
	semantic-desktop? ( dev-libs/soprano[sesame2] )"

RDEPEND="${DEPEND}
	app-arch/unzip
	daap? ( www-servers/mongrel )"

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
		$(cmake-utils_use_with ipod Ipod)
		$(cmake-utils_use_with ifp Ifp)
		$(cmake-utils_use_with mp4 Mp4v2)
		$(cmake-utils_use_with mtp Mtp)
		$(cmake-utils_use_with njb Njb)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)"
	kde4-base_src_configure
}

src_install() {
	kde4-base_src_install

	#provided by kdelibs
	rm "${D}"/"${KDEDIR}"/share/kde4/servicetypes/plasma-animator.desktop
	rm "${D}"/"${KDEDIR}"/share/kde4/servicetypes/plasma-applet.desktop
	rm "${D}"/"${KDEDIR}"/share/kde4/servicetypes/plasma-dataengine.desktop
	rm "${D}"/"${KDEDIR}"/share/kde4/servicetypes/plasma-runner.desktop
	rm "${D}"/"${KDEDIR}"/share/kde4/servicetypes/plasma-scriptengine.desktop
	rm "${D}"/"${KDEDIR}"/share/kde4/servicetypes/plasma-containment.desktop
	#provided by plasma-workspace
	rm "${D}"/"${KDEDIR}"/share/kde4/services/plasma-animator-default.desktop
	rm "${D}"/"${KDEDIR}"/lib64/kde4/plasma_animator_default.so
}
