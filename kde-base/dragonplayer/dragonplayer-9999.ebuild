# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
SLOT="kde-svn"
KMNAME=kdemultimedia
inherit kde4svn-meta

DESCRIPTION="Dragon Player is a simple video player for KDE 4"
HOMEPAGE="http://dragonplayer.org/"

LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

RDEPEND=">=media-libs/xine-lib-1.1.9
	>=media-sound/phonon-4.3"
DEPEND="${RDEPEND}
	sys-devel/gettext"
pkg_setup() {
	if ! built_with_use media-sound/phonon xine ; then
		eerror "In order to build "
		eerror "you need media-sound/phonon built with xine USE flag"
		die "no xine support in phonon"
	fi
# we got rid of that USE in phonon, maybe we want to re-enable it?
#        if ! built_with_use media-sound/phonon xcb ; then
#                eerror "In order to build "
#                eerror "you need media-sound/phonon built with xcb USE flag"
#                die "no xcb support in phonon"
#        fi

}
