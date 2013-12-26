# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="A file synchronizer especially designed for you, the normal user"
HOMEPAGE="http://owncloud.org/"
SRC_URI="http://download.owncloud.com/desktop/stable/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc iconv samba +sftp test"

RESTRICT="test"

RDEPEND="
	!net-misc/csync
	dev-db/sqlite:3
	>=dev-libs/iniparser-3.1
	net-libs/neon[ssl]
	iconv? ( virtual/libiconv )
	samba? ( net-fs/samba )
	sftp? ( net-libs/libssh )
"
DEPEND="${DEPEND}
	app-text/asciidoc
	doc? ( app-doc/doxygen )
	test? ( dev-libs/check dev-util/cmocka )
"

src_prepare() {
	cmake-utils_src_prepare

	# proper docdir
	sed -e "s:/doc/${PN}:/doc/${PF}:" \
		-i doc/CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use test UNIT_TESTING)
		$(cmake-utils_use_find_package doc Doxygen)
		$(cmake-utils_use_find_package samba Libsmbclient)
		$(cmake-utils_use_find_package sftp LibSSH)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	mv "${D}/usr/etc/${PN}" "${D}/etc/"
	rm -r "${D}/usr/etc/"
}
