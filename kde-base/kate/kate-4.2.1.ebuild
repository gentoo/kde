# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kate/kate-4.2.0.ebuild,v 1.2 2009/02/01 06:32:24 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdesdk"
inherit kde4-meta

DESCRIPTION="Kate is an MDI texteditor."
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook +plasma"

DEPEND=""
RDEPEND="${DEPEND}
	dev-libs/libxml2
	dev-libs/libxslt"

src_unpack() {
	use htmlhandbook && KMEXTRA="doc/kate-plugins"
	kde4-meta_src_unpack
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with plasma Plasma)"

	kde4-meta_src_configure
}
