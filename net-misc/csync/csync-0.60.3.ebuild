# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/csync/csync-0.60.1.ebuild,v 1.1 2012/11/16 19:39:11 johu Exp $

EAPI=4

inherit base cmake-utils

DESCRIPTION="A file synchronizer especially designed for you, the normal user"
HOMEPAGE="http://csync.org/"
SRC_URI="http://download.owncloud.com/download/o${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc log samba +sftp test +webdav"

RDEPEND="
	dev-db/sqlite:3
	>=dev-libs/iniparser-3.1
	dev-libs/openssl:0
	log? ( dev-libs/log4c )
	samba? ( net-fs/samba )
	sftp? ( net-libs/libssh )
	webdav? ( net-libs/neon )
"
DEPEND="${DEPEND}
	app-text/asciidoc
	doc? ( app-doc/doxygen )
	test? ( dev-util/cmocka )
"

PATCHES=(
	"${FILESDIR}/${PN}-0.60.2-automagicness.patch"
	"${FILESDIR}/${PN}-0.60.2-removebadtest.patch"
)

S="${WORKDIR}/o${P}"

src_prepare() {
	base_src_prepare

	if ! use doc; then
		sed -i \
			-e 's:add_subdirectory(doc)::' \
			CMakeLists.txt || die
	fi

	# proper docdir
	sed -i \
		-e "s:/doc/ocsync:/doc/${PF}:" \
		doc/CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		"-DLOG_TO_CALLBACK=ON"
		$(cmake-utils_use test UNIT_TESTING)
		$(cmake-utils_use_with doc APIDOC)
		$(cmake-utils_use_with log Log4C)
		$(cmake-utils_use_with samba Libsmbclient)
		$(cmake-utils_use_with sftp LibSSH)
		$(cmake-utils_use_with webdav Neon)
	)
	cmake-utils_src_configure
}
