# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdegraphics"
KMMODULE="libs/${PN}"
inherit kde4-meta

DESCRIPTION="SANE Library interface for KDE"
HOMEPAGE="http://www.kipi-plugins.org"
KEYWORDS=""
IUSE="debug htmlhandbook"
LICENSE="LGPL-2"

DEPEND="kde-base/qimageblitz
	media-gfx/sane-backends"
RDEPEND="${DEPEND}"

src_install() {
	insinto "${KDEDIR}"/share/apps/cmake/modules
	doins "${S}"/cmake/modules/FindKSane.cmake

	kde4-meta_src_install
}
