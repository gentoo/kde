# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils git

DESCRIPTION="Phonon VLC backend"
HOMEPAGE="https://projects.kde.org/projects/kdesupport/phonon/phonon-vlc"
EGIT_REPO_URI="git://anongit.kde.org/${PN}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=media-sound/phonon-4.4.0
	>=media-video/vlc-1.1
	>=x11-libs/qt-test-4.4.0:4
	>=x11-libs/qt-dbus-4.4.0:4
	>=x11-libs/qt-gui-4.4.0:4
	>=x11-libs/qt-opengl-4.4.0:4
"
DEPEND="${RDEPEND}
	>=dev-util/automoc-0.9.86
"

pkg_postinst() {
	elog "For more verbose debug information, export the following variables:"
	elog "PHONON_VLC_DEBUG=3"
	elog "PHONON_DEBUG=1"
	elog ""
	elog "To make KDE detect the new backend without reboot, run:"
	elog "kbuildsycoca4 --noincremental"
}
