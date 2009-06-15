# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdemultimedia"
KMMODULE="kioslave"
inherit kde4-meta

DESCRIPTION="KDE kioslaves from the kdemultimedia package"
KEYWORDS=""
IUSE="debug +handbook encode flac vorbis"

# 4 of 9 tests fail. Last checked for 4.2.88
RESTRICT=test

DEPEND="
	>=kde-base/libkcddb-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libkcompactdisc-${PV}:${SLOT}[kdeprefix=]
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
			$(cmake-utils_use_with flac)
			$(cmake-utils_use_with vorbis OggVorbis)"
	else
		mycmakeargs="${mycmakeargs}
			-DWITH_OggVorbis=OFF -DWITH_Flac=OFF"
	fi

	kde4-meta_src_configure
}
