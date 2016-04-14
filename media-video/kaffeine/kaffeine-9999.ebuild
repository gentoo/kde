# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_LINGUAS="ar ast be bg ca ca@valencia cs da de el en_GB eo es et fi fr ga gl hr hu
	it ja km ko ku lt mai nb nds nl nn pa pl pt pt_BR ro ru se sk sr@ijekavian
	sr@ijekavianlatin sr@latin sv th tr uk zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="Media player with digital TV support"
HOMEPAGE="http://kaffeine.kde.org/"
SRC_URI=""

LICENSE="GPL-2 FDL-1.2"
SLOT="4"
KEYWORDS=""
IUSE="debug"

DEPEND="
	dev-qt/qtsql:4[sqlite]
	>=media-video/vlc-1.2
	x11-libs/libXScrnSaver
"
RDEPEND="${DEPEND}"

DOCS=( Changelog NOTES )

src_configure() {
	local mycmakeargs=(
		-DBUILD_DEBUG_MODULE=$(usex debug)
	)

	kde4-base_src_configure
}
