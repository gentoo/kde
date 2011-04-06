# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="Media player for KDE using xine and gstreamer backends."
HOMEPAGE="http://kaffeine.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

COMMON_DEPEND="
	>=kde-base/phonon-kde-${KDE_MINIMAL}
	>=kde-base/solid-${KDE_MINIMAL}
	x11-libs/libXScrnSaver
"
DEPEND="${COMMON_DEPEND}
	x11-proto/scrnsaverproto
"
RDEPEND="${COMMON_DEPEND}
	!media-video/kaffeine:0
	!media-video/kaffeine:1
"
