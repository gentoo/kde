# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

#KDE_LINGUAS="en cs de hu pt_BR"
# need patch to work select linguas

KDE_MINIMAL="4.3"

inherit kde4-base

KDE_APPS_ID="114610"

DESCRIPTION="RecordItNow is a plugin based desktop recorder for KDE"
HOMEPAGE="http://kde-apps.org/content/show.php/RecordItNow?content=${KDE_APPS_ID}"
SRC_URI="http://kde-apps.org/CONTENT/content-files/${KDE_APPS_ID}-${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS=" ~amd64 ~x86"
SLOT="4"

IUSE="debug ffmpeg mplayer"

DEPEND="media-video/recordmydesktop
        ffmpeg? ( media-video/ffmpeg )
        mplayer? ( media-video/mplayer )
	x11-libs/libXfixes"

RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs="$(cmake-utils_use_with mplayer Mencoder)
		$(cmake-utils_use_with ffmpeg)"
        kde4-base_src_configure
}