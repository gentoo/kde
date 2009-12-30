# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_LINGUAS="ar bg br cs cy da de el en_GB es et fr ga gl hi hu it ja ka lt nb
nds nl pl pt pt_BR ro ru rw sv ta tg tr uk zh_CN"

inherit kde4-base

DESCRIPTION="KDE-based frontend to diff3"
HOMEPAGE="http://kdiff3.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug +handbook konqueror"

DEPEND="
	konqueror? ( >=kde-base/libkonq-${KDE_MINIMAL} )
"
RDEPEND="${DEPEND}
	sys-apps/diffutils
	konqueror? ( >=kde-base/konqueror-${KDE_MINIMAL} )
"

src_prepare() {
	kde4-base_src_prepare

	# Append missing categories
	echo "Categories=Qt;KDE;Development;" >> src/kdiff3.desktop
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with konqueror LibKonq)
	)

	kde4-base_src_configure
}
