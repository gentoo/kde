# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libksane/libksane-4.2.0.ebuild,v 1.2 2009/02/01 08:25:21 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdegraphics"
KMMODULE="libs/${PN}"
inherit kde4-meta

DESCRIPTION="SANE Library interface for KDE"
HOMEPAGE="http://www.kipi-plugins.org"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
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
