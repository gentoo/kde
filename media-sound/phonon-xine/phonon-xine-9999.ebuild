# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit cmake-utils git

DESCRIPTION="Phonon XINE backend"
HOMEPAGE="http://phonon.kde.org"
EGIT_REPO_URI="git://anongit.kde.org/${PN}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="aqua pulseaudio +xcb"

COMMON_DEPEND="
	>=media-sound/phonon-4.4.4
	>=media-libs/xine-lib-1.1.15-r1[xcb?]
	pulseaudio? (
		dev-libs/glib:2
		>=media-sound/pulseaudio-0.9.21[glib]
	)
	xcb? ( x11-libs/libxcb )
"
RDEPEND="${COMMON_DEPEND}
"
DEPEND="${COMMON_DEPEND}
	>=dev-util/automoc-0.9.87
"

pkg_setup() {
	if use aqua; then
		die "XINE backend needs X11 which is not available for USE=aqua"
	fi
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with pulseaudio GLib2)
	)

	cmake-utils_src_configure
}
