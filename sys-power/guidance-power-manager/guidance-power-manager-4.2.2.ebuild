# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_LINGUAS="cs de el en_GB es et fr ga gl it km ko lt lv ml nb nds nl nn pa pl
	pt pt_BR ro ru sv tr uk zh_CN zh_TW"

inherit python kde4-base

DESCRIPTION="KDE Power Manager control module"
HOMEPAGE="http://www.kde.org"
SRC_URI="mirror://kde/stable/${PV}/extragear/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND="
	dev-python/dbus-python
	>=kde-base/pykde4-${KDE_MINIMAL}
"
DEPEND="${RDEPEND}
	virtual/libintl
"

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
