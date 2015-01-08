# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_LINGUAS="ar ast be bg ca ca@valencia cs da de el en_GB eo es et fi fr ga gl hr hu
	it ja km ko ku lt mai nb nds nl nn pa pl pt pt_BR ro ru se sk sr@ijekavian
	sr@ijekavianlatin sr@latin sv th tr uk zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="A media player for KDE with digital TV support"
HOMEPAGE="http://kaffeine.kde.org/"
SRC_URI=""

LICENSE="GPL-2 FDL-1.2"
SLOT="4"
KEYWORDS=""
IUSE="debug"

DEPEND="
	>=media-video/vlc-1.2
	x11-libs/libXScrnSaver
	dev-qt/qtsql:4[sqlite]
"
RDEPEND="${DEPEND}"

DOCS=( Changelog NOTES )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build debug DEBUG_MODULE)
	)

	kde4-base_src_configure
}
