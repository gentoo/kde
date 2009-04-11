# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdesdk"
KMMODULE="kioslave"
inherit kde4-meta

DESCRIPTION="kioslaves from kdesdk package: the subversion kioslave"
KEYWORDS="~alpha ~amd64 ~ia64 ~x86"
IUSE="debug"

DEPEND="
	dev-libs/apr
	dev-util/subversion
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DAPRCONFIG_EXECUTABLE=/usr/bin/apr-1-config"

	kde4-meta_src_configure
}
