# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_LINGUAS="cs de es fr it nl pl ru tr"
inherit kde4-base

DESCRIPTION="LilyPond sheet music editor for KDE4"
HOMEPAGE="http://www.kde-apps.org/content/show.php/Frescobaldi?content=95853"
SRC_URI="http://lilykde.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

DEPEND="
	>=kde-base/pykde4-${KDE_MINIMAL}
	media-gfx/imagemagick[png]
	media-sound/lilypond
"
RDEPEND="${DEPEND}
	>=kde-base/okular-${KDE_MINIMAL}
"

src_prepare() {
	kde4-base_src_prepare
	# force translation update
	rm po/*.mo
}
