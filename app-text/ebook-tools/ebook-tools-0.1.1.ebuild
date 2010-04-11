# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ebook-tools/ebook-tools-0.1.1.ebuild,v 1.10 2010/01/19 02:16:55 jer Exp $

inherit cmake-utils multilib

DESCRIPTION="Tools for accessing and converting various ebook file formats."
HOMEPAGE="http://sourceforge.net/projects/ebook-tools"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-libs/libxml2
	dev-libs/libzip"
RDEPEND="${DEPEND}
	app-text/convertlit"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "/TARGETS epub/ s:lib:$(get_libdir):g" \
		"${S}"/src/libepub/CMakeLists.txt
}

src_install() {
	cmake-utils_src_install
	dodoc INSTALL README TODO
}
