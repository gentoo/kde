# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kid3/kid3-2.2.ebuild,v 1.3 2013/01/27 16:16:41 ago Exp $

EAPI=5
KDE_LINGUAS="cs de es et fi fr it nl pl ru sr sr@ijekavian sr@ijekavianlatin sr@Latn tr zh_TW"
KDE_REQUIRED="always"
KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="A simple tag editor for KDE"
HOMEPAGE="http://kid3.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="acoustid flac mp3 mp4 +taglib vorbis"

RDEPEND="
	acoustid? (
		media-libs/chromaprint
		virtual/ffmpeg
	)
	flac? (
		media-libs/flac[cxx]
		media-libs/libvorbis
	)
	mp3? ( media-libs/id3lib )
	mp4? ( media-libs/libmp4v2:0 )
	taglib? ( media-libs/taglib )
	vorbis? (
		media-libs/libogg
		media-libs/libvorbis
	)"
DEPEND="${RDEPEND}"

REQUIRED_USE="flac? ( vorbis )"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with acoustid CHROMAPRINT)
		$(cmake-utils_use_with flac)
		$(cmake-utils_use_with mp3 ID3LIB)
		$(cmake-utils_use_with mp4 MP4V2)
		$(cmake-utils_use_with vorbis)
		$(cmake-utils_use_with taglib)
		"-DWITH_KDE=ON"
		)

	kde4-base_src_configure
}
