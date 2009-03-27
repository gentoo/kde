# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dolphin/dolphin-4.2.1-r1.ebuild,v 1.1 2009/03/16 19:27:19 scarabeus Exp $

EAPI="2"

KMNAME="kdebase-apps"
inherit kde4-meta

DESCRIPTION="A KDE filemanager focusing on usability"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug +semantic-desktop thumbnail"

DEPEND="
	>=kde-base/kdelibs-${PV}:${SLOT}[kdeprefix=,semantic-desktop=]
	>=kde-base/libkonq-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}
	semantic-desktop? ( >=kde-base/nepomuk-${PV}:${SLOT}[kdeprefix=] )
	thumbnail? ( media-video/mplayerthumbs:1[kdeprefix=] )
"

KMEXTRA="
	doc/${PN}
"

KMLOADLIBS="libkonq"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)"

	kde4-meta_src_configure
}
