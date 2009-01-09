# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia-kioslaves/kdemultimedia-kioslaves-4.1.3.ebuild,v 1.2 2008/11/16 05:06:16 vapier Exp $

EAPI="2"

KMMODULE=kioslave
KMNAME=kdemultimedia
inherit kde4-meta

DESCRIPTION="KDE kioslaves from the kdemultimedia package"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
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

src_configure() {
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

	kde4-meta_src_configure
}

pkg_postinst() {
	if use encode; then
		echo
		elog "In order to use the lame plugin to encode mp3 files you will need to"
		elog "install media-sound/lame"
		echo
	fi
}
