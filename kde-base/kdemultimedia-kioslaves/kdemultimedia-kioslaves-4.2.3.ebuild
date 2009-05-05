# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia-kioslaves/kdemultimedia-kioslaves-4.2.2.ebuild,v 1.2 2009/04/17 06:27:57 alexxy Exp $

EAPI="2"

KMNAME="kdemultimedia"
KMMODULE="kioslave"
inherit kde4-meta

DESCRIPTION="KDE kioslaves from the kdemultimedia package"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug doc encode flac vorbis"

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
			$(cmake-utils_use_with flac Flac)
			$(cmake-utils_use_with vorbis OggVorbis)"
	else
		mycmakeargs="${mycmakeargs}
			-DWITH_OggVorbis=OFF -DWITH_Flac=OFF"
	fi

	kde4-meta_src_configure
}
