# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="k9copy is a DVD backup utility which allows the copy of one or more titles from a DVD9 to a DVD5"
HOMEPAGE="http://k9copy.sourceforge.net/"
ESVN_REPO_URI="https://k9copy.svn.sourceforge.net/svnroot/k9copy/kde4"
ESVN_PROJECT="k9copy"

LICENSE="GPL-2"
SLOT="live"
KEYWORDS=""
IUSE=""

DEPEND="media-libs/libdvdread
	x11-libs/qt-dbus
	sys-apps/hal
	>=media-video/ffmpeg-0.4.9_p20080326
	media-video/mplayer"

RDEPEND="${DEPEND}
	media-libs/xine-lib
	media-video/dvdauthor"

src_install() {
	kde4-base_src_install
}
