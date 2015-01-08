# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

SRC_URI="http://download.ixit.cz/distfiles/${P}.tar.xz"

DESCRIPTION="KDE Archiving tool"
HOMEPAGE="http://lamarque-lvs.blogspot.cz/2013/06/my-work-in-basyskom.html"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="+archive +bzip2 debug lzma"
SLOT="4"

S="${WORKDIR}/${PN}"
DEPEND="
	sys-libs/zlib
	archive? ( >=app-arch/libarchive-2.6.1:=[bzip2?,lzma?,zlib] )
	!kde-base/ark
"
RDEPEND="${DEPEND}"

RESTRICT="test"
# dbus problem

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with archive LibArchive)
		$(cmake-utils_use_with bzip2 BZip2)
		$(cmake-utils_use_with lzma LibLZMA)
	)
	kde4-base_src_configure
}

pkg_postinst() {
	kde4-base_pkg_postinst

	if ! has_version app-arch/rar ; then
		elog "For creating rar archives, install app-arch/rar"
	fi
}
