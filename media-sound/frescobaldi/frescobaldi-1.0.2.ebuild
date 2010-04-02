# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KDE_LINGUAS="cs de es fr gl it nl pl ru tr"
inherit kde4-base

DESCRIPTION="a LilyPond sheet music text editor for KDE"
HOMEPAGE="http://www.frescobaldi.org/"
SRC_URI="http://lilykde.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-gfx/imagemagick
	media-sound/lilypond
	dev-python/dbus-python
	>=kde-base/pykde4-${KDE_MINIMAL}"

DOCS="ChangeLog README README-development THANKS TODO po/README-translations"

src_install() {
	kde4-base_src_install
	find "${D}"/usr -name '*.pyc' -delete
}
