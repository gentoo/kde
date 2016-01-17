# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MY_PN="kwallet-pam"
inherit cmake-utils multilib

DESCRIPTION="KWallet PAM module to not enter password again"
HOMEPAGE="https://www.kde.org/"
SRC_URI="mirror://kde/stable/plasma/${PV}/${MY_PN}-${PV}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/libgcrypt:0=
	virtual/pam
"
RDEPEND="${DEPEND}
	net-misc/socat
"

S="${WORKDIR}/${MY_PN}-${PV}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="/$(get_libdir)"
		-DKWALLET4=1
	)

	cmake-utils_src_configure
}
