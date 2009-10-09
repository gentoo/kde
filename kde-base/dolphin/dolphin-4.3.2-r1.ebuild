# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dolphin/dolphin-4.3.2.ebuild,v 1.2 2009/10/06 20:53:01 alexxy Exp $

EAPI="2"

KMNAME="kdebase-apps"
inherit kde4-meta

DESCRIPTION="A KDE filemanager focusing on usability"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug +handbook +semantic-desktop thumbnail"

DEPEND="
	>=kde-base/kdelibs-${PV}:${SLOT}[kdeprefix=,semantic-desktop?]
	>=kde-base/libkonq-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}
	>=kde-base/keditfiletype-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kfind-${PV}:${SLOT}[kdeprefix=]
	semantic-desktop? ( >=kde-base/nepomuk-${PV}:${SLOT}[kdeprefix=] )
"
PDEPEND="
	thumbnail? ( >=kde-base/mplayerthumbs-${PV}:${SLOT}[kdeprefix=] )
"

KMLOADLIBS="libkonq"

PATCHES=(
	"${FILESDIR}/${PN}-4.3.1-fix-sftp-crash.patch"
)

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)"

	kde4-meta_src_configure
}
