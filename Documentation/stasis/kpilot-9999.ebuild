# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdepim
inherit kde4svn-meta

DESCRIPTION="KPilot - HotSync software for KDE."
IUSE="debug"
KEYWORDS=""

DEPEND=">=app-pda/pilot-link-0.12
	>=dev-libs/libmal-0.40
	crypt? ( app-crypt/qca:2 )"
RESTRICT="test"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with crypt QCA2)"

	kde4svn-meta_src_compile
}
