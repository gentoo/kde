# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/NVIDIA/eglexternalplatform.git"
fi

DESCRIPTION="The EGL External Platform interface"
HOMEPAGE="https://github.com/NVIDIA/eglexternalplatform"

LICENSE="MIT"
SLOT="0"

IUSE="examples"

src_install() {
	einstalldocs

	doheader -r interface/.
	insinto /usr/$(get_libdir)/pkgconfig/
	doins eglexternalplatform.pc

	if use examples; then
		docinto samples
		dodoc samples/*.c
	fi
}
