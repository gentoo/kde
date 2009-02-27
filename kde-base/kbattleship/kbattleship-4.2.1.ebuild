# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kbattleship/kbattleship-4.2.0.ebuild,v 1.2 2009/02/01 06:33:37 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdegames"
inherit games-ggz kde4-meta

DESCRIPTION="The KDE Battleship clone"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"

src_prepare() {
	# cmake is doing this really weird
	sed -i \
		-e "s:register_ggz_module:#register_ggz_module:g" \
		${PN}/src/CMakeLists.txt || die "ggz removal failed"

	kde4-meta_src_prepare
}

src_install() {
	kde4-meta_src_install
	# and also we have to prepare the ggz dir
	mkdir -p "${D}"/usr/share/ggz/modules
	cp ${PN}/src/module.dsc "${D}"/usr/share/ggz/modules/${P}.dsc
}

pkg_postinst() {
	kde4-meta_pkg_postinst
	games-ggz_pkg_postinst
}

pkg_postrm() {
	kde4-meta_pkg_postrm
	games-ggz_pkg_postrm
}
