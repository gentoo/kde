# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde-frameworks

DESCRIPTION="Framework providing platform independent hardware discovery, abstraction, and management"
LICENSE="LGPL-2.1+"
KEYWORDS=""
IUSE="+udev"

RDEPEND="
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	udev? ( virtual/udev )
"
DEPEND="${RDEPEND}
	test? ( dev-qt/qtconcurrent:5 )
"

src_configure() {
	# HUpnp is currently disabled upstream due to
	# being buggy and unmaintained
	local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_HUpnp=true
		$(cmake-utils_use_find_package udev UDev)
	)

	kde-frameworks_src_configure
}
