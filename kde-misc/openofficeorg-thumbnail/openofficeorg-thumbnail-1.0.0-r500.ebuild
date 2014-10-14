# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
MY_PN="OpenOfficeorgThumbnail"
MY_P="${MY_PN}-${PV}"

inherit kde5

DESCRIPTION="KDE thumbnail-plugin that generates thumbnails for ODF files"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=110864"
SRC_URI="http://arielch.fedorapeople.org/devel/src/${MY_P}.tar.gz"

LICENSE="LGPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kio)
	dev-qt/qtgui:5
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}
PATCHES=( "${FILESDIR}"/${P}-kf5-support.patch )
