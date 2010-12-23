# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit git kde4-base

DESCRIPTION="A user friendly IRC Client for KDE4"
HOMEPAGE="http://konversation.kde.org"
EGIT_REPO_URI="git://anongit.kde.org/${PN}"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="+crypt debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	crypt? ( app-crypt/qca:2 )
"
RDEPEND="${DEPEND}"

src_unpack() {
	git_src_unpack
}

src_configure() {
	mycmakeargs=($(cmake-utils_use_with crypt QCA2))
	kde4-base_src_configure
}
