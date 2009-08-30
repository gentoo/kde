# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="A tool to create interactive applets for the KDE desktop."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug +handbook python"

DEPEND="
	kde-base/qimageblitz
	python? ( >=kde-base/pykde4-${PV}:${SLOT}[kdeprefix=] )
"
RDEPEND="${DEPEND}
	python? ( >=kde-base/krosspython-${PV}:${SLOT}[kdeprefix=] )
"

PATCHES=( "${FILESDIR}/${PN}-as-needed.patch" )

src_prepare() {
	kde4-meta_src_prepare

	# Remove compile-time dep on LibKNotificationItem
	sed -i -e '/LibKNotificationItem-1/s/^/#DONOTNEED /' CMakeLists.txt
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with python PythonLibs)"

	kde4-meta_src_configure
}
