# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_MINIMAL="4.2"
KDE_LINGUAS="ca cs de el es_AR es et fr it nl pl pt_BR ru sr sr@Latn tr zh_TW"

inherit kde4-base

DESCRIPTION="k9copy is a DVD backup utility which allows the copy of one or more titles from a DVD9 to a DVD5."
HOMEPAGE="http://k9copy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-Source.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="2"
IUSE="debug"

DEPEND="
	media-libs/libdvdread
	media-libs/xine-lib
	>=media-video/ffmpeg-0.4.9_p20081014
	x11-libs/qt-dbus:4
"
RDEPEND="${DEPEND}
	!kdeprefix? ( !app-cdr/k9copy:0 )
	media-video/dvdauthor
	media-video/mplayer
"

S="${WORKDIR}/${P}-Source"

src_prepare() {
	sed -i -e 's/sr@latin/sr@Latn/g' \
		"${S}"/po/cmake_install.cmake || die "sed failed"
	mv -i "${S}"/po/sr@latin.po "${S}"/po/sr@Latn.po
	enable_selected_linguas

	kde4-base_src_prepare
}

pkg_postinst() {
	echo
	elog "If you want K3b burning support in ${P}, please install app-cdr/k3b separately."
	elog "If you want phonon media playback in ${P}, please install media-sound/phonon separately."
	echo
}
