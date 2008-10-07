# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayerthumbs/mplayerthumbs-0.5b.ebuild,v 1.3 2008/06/29 12:05:39 loki_val Exp $

EAPI="2"
NEED_KDE=":4.1"
inherit kde4-base

DESCRIPTION="A Thumbnail Generator for Video Files on Konqueror."
HOMEPAGE="http://www.kde-look.org/content/show.php?content=41180"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/41180-${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="4.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="( || ( >=kde-base/dolphin-4.1.1:${SLOT} >=kde-base/kdebase-4.1.1:${SLOT} >=kde-base/konqueror-4.1.1:${SLOT} ) )
		( || ( media-video/mplayer media-video/mplayer-bin ) )"

PREFIX="${KDEDIR}"
