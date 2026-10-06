# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_AUTODEPS=minimal
KFMIN=9999
inherit branding ecm plasma.kde.org

DESCRIPTION="Breeze theme for Plymouth"

LICENSE="GPL-2+ GPL-3+"
SLOT="6"
KEYWORDS=""
IUSE=""

DEPEND="sys-boot/plymouth"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DDISTRO_NAME="${BRANDING_OS_NAME}"
		-DDISTRO_VERSION="${BRANDING_OS_VERSION}"
	)

	ecm_src_configure
}
