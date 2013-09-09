# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FRAMEWORKS_DOXYGEN="true"
FRAMEWORKS_TYPE="tier1"
VIRTUALX_REQUIRED="test"
inherit kde-frameworks

DESCRIPTION="Hardware discovery and power and network management framework"
LICENSE="LGPL-2.1+"
KEYWORDS=""
IUSE="+udev"

RDEPEND="
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	udev? ( virtual/udev )
"
DEPEND="${RDEPEND}
	test? ( dev-qt/qtconcurrent:5 )
"

DOCS=( README TODO )

src_configure() {
	local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_HUpnp=true
		$(cmake-utils_use_find_package udev UDev)
	)

	kde-frameworks_src_configure
}
