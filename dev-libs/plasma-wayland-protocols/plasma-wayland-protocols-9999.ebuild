# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_AUTODEPS=minimal
KDE_VERIFY_SIG=1
inherit ecm kde.org

DESCRIPTION="Plasma Specific Protocols for Wayland"
HOMEPAGE="https://invent.kde.org/libraries/plasma-wayland-protocols"

if [[ ${KDE_BUILD_TYPE} == release ]]; then
	SRC_URI="mirror://kde/stable/${PN}/${P}.tar.xz"
	if [[ -n ${KDE_VERIFY_SIG} ]]; then
		SRC_URI+=" verify-sig? ( mirror://kde/stable/${PN}/${P}.tar.xz.sig )"
	fi
	KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc64 ~riscv ~x86"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="test? ( dev-libs/wayland )"
BDEPEND="test? ( dev-util/wayland-scanner )"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt6CoreTools=ON # testing for bug #923502
		-DBUILD_TESTING=$(usex test)
	)

	ecm_src_configure
}
