# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdewebdev"
inherit kde4-meta

DESCRIPTION="A KDE KPart Application for xsldbg, an XSLT debugger"
KEYWORDS="~amd64 ~x86"
IUSE="tidy"

DEPEND="dev-libs/libxslt
	dev-libs/libxml2"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with tidy LibTidy)"
	kde4-meta_src_configure
}
