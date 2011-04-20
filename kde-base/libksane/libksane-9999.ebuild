# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
if [[ ${PV} == *9999 ]]; then
	inherit kde4-base
else
	KMNAME="kdegraphics"
	KMMODULE="libs/${PN}"
	inherit kde4-meta
fi

DESCRIPTION="SANE Library interface for KDE"
HOMEPAGE="http://www.kipi-plugins.org"
KEYWORDS=""
IUSE="debug"
LICENSE="LGPL-2"

DEPEND="
	media-gfx/sane-backends
"
RDEPEND="${DEPEND}"

# Not sure where this moved/who should install it in 4.7+
if [[ ${PV} != *9999 ]]; then
src_install() {
	insinto "${KDEDIR}"/share/apps/cmake/modules
	doins "${S}"/cmake/modules/FindKSane.cmake

	kde4-meta_src_install
}
fi
