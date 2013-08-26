# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit virtuoso java-pkg-2

DESCRIPTION="JDBC driver for OpenLink Virtuoso Open-Source Edition"

#Upstream says no 32-bit (yet), https://github.com/openlink/virtuoso-opensource/issues/69
KEYWORDS="~amd64 -x86"
IUSE=""

#Force 1.7 until we decide on how to handle multiple versions at once
DEPEND="
	>=virtual/jdk-1.7.0
"
RDEPEND="
	>=virtual/jre-1.7.0
"

VOS_EXTRACT="
	libsrc/JDBCDriverType4
"

pkg_pretend() {
	java-pkg_ensure-vm-version-eq 1.7
}
src_prepare() {
	java-pkg-2_src_prepare
	virtuoso_src_prepare
}

src_configure() {
	myconf+="
		--with-jdk4_1=$(java-config-2 -O)
	"

	MAKEOPTS=-j1

	virtuoso_src_configure
}
