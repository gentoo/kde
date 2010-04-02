# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/sdk"
KMMODULE="kdevelop-plugins"
inherit kde4-base

DESCRIPTION="Various plugins for kdevelop (support for other langs)"
HOMEPAGE="http://www.kdevelop.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="4"
KEYWORDS=""

PLUGINS="+php +php-docs"
IUSE="debug ${PLUGINS}"
PLUGINS="${PLUGINS//+/}"

DEPEND="
	>=dev-util/kdevelop-${PV}:${SLOT}
"
RDEPEND="${DEPEND}"

src_prepare() {
	:
}

src_configure() {
	for plugin in ${PLUGINS}; do
		if use ${plugin}; then
			CMAKE_USE_DIR="${WORKDIR}/${P}/${plugin}"
			kde4-base_src_configure
		fi
	done
}

src_compile() {
	for plugin in ${PLUGINS}; do
		if use ${plugin}; then
			CMAKE_USE_DIR="${WORKDIR}/${P}/${plugin}"
			kde4-base_src_compile
		fi
	done
}

src_install() {
	for plugin in ${PLUGINS}; do
		if use ${plugin}; then
			CMAKE_USE_DIR="${WORKDIR}/${P}/${plugin}"
			kde4-base_src_install
		fi
	done
}
