# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/parley/parley-4.2.1.ebuild,v 1.2 2009/03/08 14:19:00 scarabeus Exp $

EAPI="2"

KMNAME="kdeedu"
inherit kde4-meta

DESCRIPTION="KDE Educational: vocabulary trainer"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug +plasma"

DEPEND="
	>=kde-base/libkdeedu-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	libkdeedu/keduvocdocument
"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with plasma Plasma)"

	kde4-meta_src_configure
}
