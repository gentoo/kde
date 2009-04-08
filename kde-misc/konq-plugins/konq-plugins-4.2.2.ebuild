# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_LINGUAS="af ar be bg bn br ca cs cy da de el en_GB eo es et eu fa fi fr fy ga
	gl he hi hr hsb hu is it ja kk km ko ku lt lv mk ml ms nb nds ne nl nn oc pa
	pl pt pt_BR ro ru se sk sl sr sv ta tg th tr uk uz uz@cyrillic vi xh zh_CN zh_TW"

KMNAME="extragear/base"
KMNOMODULE="true"
inherit kde4-base

DESCRIPTION="Various plugins for konqueror"
HOMEPAGE="http://kde.org/"
SRC_URI="mirror://kde/stable/${PV}/extragear/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
SLOT="4"
IUSE="debug doc"

DEPEND="
	>=kde-base/libkonq-${KDE_MINIMAL}
"
RDEPEND="${DEPEND}
	!kde-base/konq-plugins:4.1[-kdeprefix]
	!kde-base/konq-plugins:4.2[-kdeprefix]
	>=kde-base/kcmshell-${KDE_MINIMAL}
	>=kde-base/konqueror-${KDE_MINIMAL}
"

src_prepare() {
	if ! use doc; then
		sed -i \
			-e "s:macro_optional_add_subdirectory(doc):#nada:g" \
			CMakeLists.txt || die "sed doc failed"
	else
		sed -i \
			-e "s:\${HTML_INSTALL_DIR}/en:\${HTML_INSTALL_DIR}/en SUBDIR ${PN}:g" \
			doc/CMakeLists.txt || die "fix doc placement failed"
	fi

	kde4-base_src_prepare
}
