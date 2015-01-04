# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="extragear/sdk"
KDE_LINGUAS_LIVE_OVERRIDE="true"
inherit kde4-meta

DESCRIPTION="A KDE KPart Application for xsldbg, an XSLT debugger"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="
	dev-libs/libxslt
	dev-libs/libxml2
"
RDEPEND="${DEPEND}"

src_unpack() {
	if use handbook; then
		KMEXTRA="doc/xsldbg doc/kxsldbg"
	fi

	kde4-meta_src_unpack
}

src_configure() {
	local mycmakeargs=(-DWITH_LibXml2=ON -DWITH_Xslt=ON)

	kde4-meta_src_configure
}
