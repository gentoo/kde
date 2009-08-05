# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/guidance-power-manager/guidance-power-manager-4.2.4.ebuild,v 1.1 2009/07/22 23:15:17 wired Exp $

EAPI="2"

KDE_LINGUAS="cs de el en_GB es et fr ga gl it km ko lt lv ml nb nds nl nn pa pl
	pt pt_BR ro ru sv tr uk zh_CN zh_TW"

inherit python kde4-base

DESCRIPTION="KDE Power Manager control module"
HOMEPAGE="http://www.kde.org"
SRC_URI="mirror://kde/stable/${PV}/src/extragear/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE=""

RDEPEND="
	dev-python/dbus-python
	>=kde-base/pykde4-${KDE_MINIMAL}
"
DEPEND="${RDEPEND}
	virtual/libintl
"

src_prepare() {
	sed -e 's|PYKDE|PYKDE4|g' \
		-e 's|PyKDE|PyKDE4|g' \
		-i CMakeLists.txt || die "failed to fix broken PyKDE4 checks"

	kde4-base_src_prepare
}

pkg_postinst() {
	kde4-base_pkg_postinst

	python_version
	python_mod_compile "/usr/$(get_libdir)/python${PYVER}"/site-packages/xf86misc.py
	python_mod_optimize "${PREFIX}"/share/apps/"${PN}"
}

pkg_postrm() {
	kde4-base_pkg_postrm

	python_mod_cleanup
	python_mod_cleanup "${PREFIX}"/share/apps/"${PN}"
}
