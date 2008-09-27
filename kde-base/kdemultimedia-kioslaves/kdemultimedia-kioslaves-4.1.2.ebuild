# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMMODULE=kioslave
KMNAME=kdemultimedia
inherit kde4-meta

DESCRIPTION="KDE kioslaves from the kdemultimedia package"
KEYWORDS="~amd64 ~x86"
IUSE="debug encode flac vorbis"

# Tests are broken. Last checked on 4.0.3.
#RESTRICT="test"

DEPEND="${DEPEND}
	>=kde-base/libkcddb-${PV}:${SLOT}
	>=kde-base/libkcompactdisc-${PV}:${SLOT}
	media-sound/cdparanoia
	encode? ( flac? ( >=media-libs/flac-1.1.2 )
		vorbis? ( media-libs/libvorbis ) )"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libkcddb/
	libkcompactdisc/"
#KMCOMPILEONLY="libkcddb/"
KMLOADLIBS="libkcddb"

src_compile() {
	ln -s "${PREFIX}"/include/libkcddb/configbase.h \
		"${WORKDIR}"/${P}/kioslave/audiocd/ \
	|| die "linking generated header into sources failed"

	if use encode; then
		mycmakeargs="${mycmakeargs}
			$(cmake-utils_use_with flac Flac)
			$(cmake-utils_use_with vorbis OggVorbis)"
	else
		mycmakeargs="${mycmakeargs}
			-DWITH_OggVorbis=OFF -DWITH_Flac=OFF"
	fi

	kde4-meta_src_compile
}

pkg_postinst() {
	if use encode; then
		echo
		elog "In order to use the lame plugin to encode mp3 files you will need to"
		elog "install media-sound/lame"
		echo
	fi
}
