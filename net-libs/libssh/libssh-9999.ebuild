# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libssh/libssh-0.3.4.ebuild,v 1.3 2009/10/24 12:43:58 nixnut Exp $

# Maintainer: check IUSE-defaults at DefineOptions.cmake

EAPI="2"

inherit eutils cmake-utils git

DESCRIPTION="Access a working SSH implementation by means of a library"
HOMEPAGE="http://www.libssh.org/"
EGIT_REPO_URI="git://git.libssh.org/projects/libssh/libssh.git"

LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ppc ~s390 x86"
SLOT="0"
IUSE="debug gcrypt examples +sftp ssh1 server static-libs zlib"

DEPEND="
	zlib? ( >=sys-libs/zlib-1.2 )
	!gcrypt? ( >=dev-libs/openssl-0.9.8 )
	gcrypt? ( >=dev-libs/libgcrypt-1.4 )
"
RDEPEND="${DEPEND}"

DOCS="AUTHORS README ChangeLog"

src_prepare() {
	sed -i '/add_subdirectory(examples)/s/^/#DONOTWANT/' CMakeLists.txt
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with debug DEBUG_CALLTRACE)
		$(cmake-utils_use_with debug DEBUG_CRYPTO)
		$(cmake-utils_use_with gcrypt)
		$(cmake-utils_use_with zlib LIBZ)
		$(cmake-utils_use_with sftp)
		$(cmake-utils_use_with ssh1)
		$(cmake-utils_use_with server)
		$(cmake-utils_use_with static-libs STATIC_LIB)
	"

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	if use examples; then
		insinto "${ROOT}"usr/share/doc/"${PF}"/examples
		doins examples/*.c
	fi
}
