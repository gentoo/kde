# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_REQUIRED="optional"
LANGS="ar bg br cs cy da de el en_GB es et fr ga gl hi hu it ja ka lt nb
nds nl pl pt pt_BR ro ru rw sv ta tg tr uk zh_CN"
KDE_LINGUAS="${LANGS}"
QT_MINIMAL="4.4.0"

inherit kde4-base qt4-r2

DESCRIPTION="KDE-based frontend to diff3"
HOMEPAGE="http://kdiff3.sourceforge.net/"
SRC_URI="mirror://sourceforge/kdiff3/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux"
SLOT="4"
IUSE="debug +handbook kde konqueror"

DEPEND="
	>=x11-libs/qt-core-${QT_MINIMAL}
	>=x11-libs/qt-gui-${QT_MINIMAL}
	kde? (
		$(add_kdebase_dep kdelibs)
		konqueror? ( $(add_kdebase_dep libkonq) )
	)
"
RDEPEND="${DEPEND}
	sys-apps/diffutils
"

src_prepare() {
	if ! use kde; then
		# adapt to Gentoo paths
		sed -e s,documentation.path.*$,documentation.path\ =\ /usr/share/doc/${PF}, \
			-e s,target.path.*$,target.path\ =\ /usr/bin, \
			"${S}"/src-QT4/kdiff3.pro > "${S}"/src-QT4/kdiff3_fixed.pro
	fi
}

src_configure() {
	if use kde; then
		mycmakeargs=( $(cmake-utils_use_with konqueror LibKonq) )
		kde4-base_src_configure
	else
		eqmake4 "${S}"/src-QT4/kdiff3_fixed.pro
	fi
}

src_compile() {
	if use kde; then
		kde4-base_src_compile
	else
		qt4-r2_src_compile
	fi
}

src_install() {
	if use kde; then
		kde4-base_src_install
	else
		qt4-r2_src_install
	fi
}
