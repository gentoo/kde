# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdesdk"
inherit kde4-meta

DESCRIPTION="Kate is an MDI texteditor."
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook +plasma"

DEPEND="
	dev-libs/libxml2
	dev-libs/libxslt
"
RDEPEND="${DEPEND}"

src_unpack() {
	use htmlhandbook && KMEXTRA="doc/kate-plugins"

	kde4-meta_src_unpack
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with plasma Plasma)"

	kde4-meta_src_configure
}
