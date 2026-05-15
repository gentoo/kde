# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
"
RUST_MIN_VER="1.87.0"

inherit cargo

DESCRIPTION="C++ code generator for integrating 'cxx' crate into a non-Cargo build"
HOMEPAGE="https://cxx.rs"
SRC_URI="
	https://github.com/dtolnay/cxx/releases/download/${PV}/cxx-${PV}.tar.gz
	${CARGO_CRATE_URIS}
"

if [[ ${PKGBUMPING} != ${PVR} ]]; then
	SRC_URI+=" https://github.com/gentoo-crate-dist/cxx/releases/download/${PV}/cxx-${PV}-crates.tar.xz"
fi

S="${WORKDIR}/cxx-${PV}/gen/cmd"

LICENSE="|| ( Apache-2.0 MIT )"
# Dependent crate licenses
LICENSE+=" Apache-2.0 MIT Unicode-3.0 ZLIB"
SLOT="0"
KEYWORDS="~amd64"

QA_FLAGS_IGNORED=".*"
