# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="A simple plasmoid that shows a slideshow of the current interesting images on flickr."
HOMEPAGE="http://kde-look.org/content/show.php/Flickr+Plasmoid?content=83246"
SRC_URI="http://kde-look.org/CONTENT/content-files/83246-flickrplasmoid.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="!kde-misc/plasmoids
		kde-base/libplasma"

S="${WORKDIR}/FlickrPlasmoid"
