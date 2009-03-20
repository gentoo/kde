# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="k9copy is a DVD backup utility which allows the copy of one or more titles from a DVD9 to a DVD5."
HOMEPAGE="http://k9copy.sourceforge.net/"
ESVN_REPO_URI="https://k9copy.svn.sourceforge.net/svnroot/k9copy/kde4"
ESVN_PROJECT="k9copy"

LICENSE="GPL-2"
KEYWORDS=""
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

src_prepare() {
	sed -i -e\
		"s:install(FILES k9copy_assistant_open.desktop:\
		#install(FILES k9copy_assistant_open.desktop:"\
		"${S}"/CMakeLists.txt || die "sed failed"

	kde4-base_src_prepare
}

pkg_postinst() {
	echo
	elog "If you want K3b burning support in ${P}, please install app-cdr/k3b separately."
	elog "If you want phonon media playback in ${P}, please install media-sound/phonon separately."
	echo
}
