# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

if [[ ${PV} == *9999* ]] ; then
	KMNAME="extragear/network"
else
	# upstream likes to skip that _ in beta releases
	KTORRENT_VERSION="4.0rc1"
	MY_PV="${PV/_/}"
	MY_P="${PN}-${MY_PV}"

	SRC_URI="http://ktorrent.org/downloads/${KTORRENT_VERSION}/${MY_P}.tar.bz2"
	S="${WORKDIR}"/"${MY_P}"
fi

inherit kde4-base

DESCRIPTION="A BitTorrent library based on KDE Platform"
HOMEPAGE="http://ktorrent.org/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug doc"

COMMONDEPEND="
	app-crypt/qca:2
	dev-libs/gmp
"
DEPEND="${COMMONDEPEND}
	dev-libs/boost
	sys-devel/gettext
	doc? ( app-doc/doxygen[-nodot] )
"
RDEPEND="${COMMONDEPEND}"

src_compile() {
	cmake-utils_src_compile

	use doc && cmake-utils_src_compile docs
}

src_install() {
	use doc && HTML_DOCS=("${CMAKE_BUILD_DIR}/apidocs/html/")

	cmake-utils_src_install
}
