# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
"
RUST_MIN_VER="1.85.0"

# TODO: ECMGenerateQDoc
ECM_TEST="true"
inherit cargo ecm flag-o-matic kde.org

DESCRIPTION="C++ library for parsing CSS that uses the Rust cssparser crate internally"
HOMEPAGE="https://invent.kde.org/libraries/cxx-rust-cssparser"

if [[ ${KDE_BUILD_TYPE} == release ]]; then
	SRC_URI="mirror://kde/stable/${KDE_ORG_NAME}/${KDE_ORG_NAME}-${PV}.tar.xz"
	KEYWORDS="~amd64"
	if [[ ${PKGBUMPING} != ${PVR} ]]; then
		SRC_URI+=" https://github.com/gentoo-crate-dist/${PN}/releases/download/v${PV}/${P}-crates.tar.xz"
	fi
fi

LICENSE="BSD-2 CC0-1.0 || ( LGPL-2.1 LGPL-3 )"
# Dependent crate licenses
LICENSE+=" Apache-2.0 MIT MPL-2.0 Unicode-3.0 ZLIB"
SLOT="0"

BDEPEND="
	dev-build/corrosion
	dev-build/cxxbridge-cmd
"

src_configure() {
	# Rust extensions are incompatible with C/C++ LTO compiler see e.g.
	# https://bugs.gentoo.org/910220
	filter-lto

	ecm_src_configure
}
