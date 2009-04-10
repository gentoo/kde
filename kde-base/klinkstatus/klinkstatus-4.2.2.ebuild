# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/klinkstatus/klinkstatus-4.2.1.ebuild,v 1.2 2009/03/08 13:46:11 scarabeus Exp $

EAPI="2"
KMNAME="kdewebdev"
inherit kde4-meta

DESCRIPTION="KDE web development - link validity checker"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug doc tidy"

DEPEND="
	>=kde-base/kdepimlibs-${PV}:${SLOT}[kdeprefix=]
	tidy? ( app-text/htmltidy )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DWITH_KdepimLibs=ON
		$(cmake-utils_use_with tidy LibTidy)"

	kde4-meta_src_configure
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	echo
	elog "To use scripting in ${PN}, install dev-lang/ruby."
	echo
}
