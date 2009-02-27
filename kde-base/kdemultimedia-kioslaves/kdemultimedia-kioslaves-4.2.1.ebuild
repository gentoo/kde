# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia-kioslaves/kdemultimedia-kioslaves-4.2.0.ebuild,v 1.2 2009/02/01 06:58:08 jmbsvicetto Exp $

EAPI="2"

KMMODULE="kioslave"
KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="KDE kioslaves from the kdemultimedia package"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug encode flac vorbis"

DEPEND="
	>=kde-base/libkcddb-${PV}:${SLOT}
	>=kde-base/libkcompactdisc-${PV}:${SLOT}
	media-sound/cdparanoia
	encode? (
		flac? ( >=media-libs/flac-1.1.2 )
		vorbis? ( media-libs/libvorbis )
	)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	libkcompactdisc/
"
KMCOMPILEONLY="
	libkcddb/
"

KMLOADLIBS="libkcddb"

src_configure() {
	if use encode; then
		mycmakeargs="${mycmakeargs}
			$(cmake-utils_use_with flac Flac)
			$(cmake-utils_use_with vorbis OggVorbis)"
	else
		mycmakeargs="${mycmakeargs}
			-DWITH_OggVorbis=OFF -DWITH_Flac=OFF"
	fi

	kde4-meta_src_configure
}
