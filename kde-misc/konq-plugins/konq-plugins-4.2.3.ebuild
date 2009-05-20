# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/konq-plugins/konq-plugins-4.2.2.ebuild,v 1.1 2009/04/26 11:29:44 tampakrap Exp $

EAPI="2"

KDE_LINGUAS="af ar be bg bn br ca cs cy da de el en_GB eo es et eu fa fi fr fy ga
	gl he hi hr hsb hu is it ja kk km ko ku lt lv mk ml ms nb nds ne nl nn oc pa
	pl pt pt_BR ro ru se sk sl sr sv ta tg th tr uk uz uz@cyrillic vi xh zh_CN zh_TW"

KMNAME="extragear/base"
KMNOMODULE="true"
inherit kde4-base

DESCRIPTION="Various plugins for konqueror"
HOMEPAGE="http://kde.org/"
SRC_URI="mirror://kde/stable/${PV}/src/extragear/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
SLOT="4"
IUSE="debug doc tidy"

DEPEND="
	>=kde-base/libkonq-${KDE_MINIMAL}
	tidy? ( app-text/htmltidy )
"
RDEPEND="${DEPEND}
	!kde-base/konq-plugins:4.1[-kdeprefix]
	!kde-base/konq-plugins:4.2[-kdeprefix]
	>=kde-base/kcmshell-${KDE_MINIMAL}
	>=kde-base/konqueror-${KDE_MINIMAL}
"

src_prepare() {
	if ! use doc; then
		sed -e 's|add_subdirectory( doc )||' \
			-e 's|add_subdirectory( doc-translations )||' \
			-i CMakeLists.txt || die "failed to disable docs"
	fi

	kde4-base_src_prepare
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DKdeWebKit=OFF
		-DWebKitPart=OFF
		$(cmake-utils_use_with tidy LibTidy)"

	kde4-base_src_configure
}
