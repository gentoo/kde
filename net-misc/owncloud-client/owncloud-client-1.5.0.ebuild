# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

MY_PN=mirall
MY_P="${MY_PN}-${PV/_/}"

DESCRIPTION="Synchronization of your folders with another computers"
HOMEPAGE="http://owncloud.org/"
SRC_URI="http://download.owncloud.com/desktop/stable/${MY_P}.tar.bz2"

LICENSE="CC-BY-3.0 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="
	!net-misc/mirall
	dev-qt/qtcore:4
	dev-qt/qtdbus:4
	dev-qt/qtgui:4
	dev-qt/qttest:4
	dev-qt/qtwebkit:4
	>=net-misc/ocsync-0.91.4
	sys-fs/inotify-tools
	dev-libs/qtkeychain
"
DEPEND="${RDEPEND}
	doc? (
		dev-python/sphinx
		dev-texlive/texlive-latexextra
		virtual/latex-base
	)
"

S=${WORKDIR}/${MY_P}

src_configure() {
	export CSYNC_DIR="${EPREFIX}/usr/include/ocsync/"

	local mycmakeargs=(
		-DCMAKE_INSTALL_DOCDIR=/usr/share/doc/${PF}
		$(cmake-utils_use_with doc)
	)
	cmake-utils_src_configure
}

src_compile() {
	use doc && cmake-utils_src_compile -j1 doc
	cmake-utils_src_compile
}

pkg_postinst() {
	if ! has_version net-misc/ocsync[samba]; then
		elog "For samba support, build net-misc/ocsync with USE=samba"
	fi
	if ! has_version net-misc/ocsync[sftp]; then
		elog "For sftp support, build net-misc/ocsync with USE=sftp"
	fi
}
