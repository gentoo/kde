# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdiff3/kdiff3-0.9.95-r1.ebuild,v 1.1 2011/01/12 22:46:57 tampakrap Exp $

EAPI=4

KDE_REQUIRED="optional"
QT_MINIMAL="4.4.0"

if [[ ${PV} != *9999* ]]; then
	KDE_LINGUAS="ar bg br cs cy da de el en_GB es et fr ga gl hi hu it ja ka lt nb
	nds nl pl pt pt_BR ro ru rw sv ta tg tr uk zh_CN"
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
	KDE_HANDBOOK="optional"
fi

inherit kde4-base qt4-r2

DESCRIPTION="Qt/KDE based frontend to diff3"
HOMEPAGE="http://kdiff3.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug kde konqueror"

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

RESTRICT="!kde? ( test )"

src_unpack(){
	if [[ ${PV} == *9999* ]]; then
		ESVN_REPO_URI="https://kdiff3.svn.sourceforge.net/svnroot/kdiff3/trunk/kdiff3"
		subversion_src_unpack
	elif use kde; then
		kde4-base_src_unpack
	else
		qt4-r2_src_unpack
	fi
}

src_prepare() {
	if ! use kde; then
		# adapt to Gentoo paths
		sed -e s,documentation.path.*$,documentation.path\ =\ /usr/share/doc/${PF}, \
			-e s,target.path.*$,target.path\ =\ /usr/bin, \
			"${S}"/src-QT4/kdiff3.pro > "${S}"/src-QT4/kdiff3_fixed.pro
	else
		kde4-base_src_prepare
	fi

	echo "Categories=Qt;KDE;Development;" >> "${S}"/src-QT4/kdiff3.desktop
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

src_test() {
	if use kde; then
		kde4-base_src_test
	fi
}
