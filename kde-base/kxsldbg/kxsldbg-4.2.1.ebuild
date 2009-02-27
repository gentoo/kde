# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kxsldbg/kxsldbg-4.2.0.ebuild,v 1.2 2009/02/01 08:17:21 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdewebdev"
inherit kde4-meta

DESCRIPTION="A KDE KPart Application for xsldbg, an XSLT debugger"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug tidy"

DEPEND="
	dev-libs/libxslt
	dev-libs/libxml2
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with tidy LibTidy)"

	kde4-meta_src_configure
}
