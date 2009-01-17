# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="playground/multimedia"
inherit kde4-base

DESCRIPTION="kdetv is a KDE application to watch TV on the desktop."
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=11602"

LICENSE="GPL-2"
SLOT="live"
KEYWORDS=""
IUSE="debug v4l2 zvbi"

DEPEND="
	v4l2? ( >=sys-kernel/linux-headers-2.6.11 )
	zvbi? ( media-libs/zvbi )
"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with v4l2 v4l2)
		$(cmake-utils_use_with zvbi zvbi)
	"
	kde4-base_src_configure
}
