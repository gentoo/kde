# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
if [[ ${PV} == *9999 ]]; then
	kde_eclass="kde4-base"
else
	KMNAME="kdegraphics"
	KMMODULE="libs/${PN}"
	kde_eclass="kde4-meta"
fi
inherit ${kde_eclass}

DESCRIPTION="SANE Library interface for KDE"
HOMEPAGE="http://www.kipi-plugins.org"
KEYWORDS=""
IUSE="debug"
LICENSE="LGPL-2"

DEPEND="
	media-gfx/sane-backends
"
RDEPEND="${DEPEND}"

# Not sure where this moved/who should install it in 4.6.3+
if [[ ${PV} != *9999 ]]; then
src_install() {
	insinto /usr/share/apps/cmake/modules
	doins "${S}"/cmake/modules/FindKSane.cmake

	${kde_eclass}_src_install
}
fi
