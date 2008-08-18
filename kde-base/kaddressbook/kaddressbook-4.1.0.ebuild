# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdepim
inherit kde4-meta

DESCRIPTION="The KDE Address Book"
KEYWORDS="~amd64"
IUSE="debug gnokii htmlhandbook"

DEPEND=">=kde-base/libkdepim-${PV}:${SLOT}
	>=kde-base/libkleo-${PV}:${SLOT}
	gnokii? ( app-mobilephone/gnokii )"
RDEPEND="${DEPEND}"

# xml targets from kmail are being uncommented by kde4-meta.eclass
KMEXTRACTONLY="kmail/
	libkdepim/
	libkleo/"
KMLOADLIBS="libkdepim libkleo"

src_compile(){
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with gnokii GNOKII)"

	kde4-meta_src_compile
}
