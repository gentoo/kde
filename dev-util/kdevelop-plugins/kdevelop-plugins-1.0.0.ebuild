# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

KDEVELOP_PV="4.0.0"
DESCRIPTION="PHP plugin for KDevelop 4."
HOMEPAGE="http://www.kdevelop.org/"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"

PLUGINS="+php +php-docs"
IUSE="debug ${PLUGINS}"
PLUGINS="${PLUGINS//+/}"

for plugin in ${PLUGINS}; do
	SRC_URI+=" ${plugin}? ( mirror://kde/stable/kdevelop/${KDEVELOP_PV}/src/kdevelop-${plugin}-${PV}.tar.bz2 )"
done

DEPEND="
	>=dev-util/kdevplatform-${PV}
"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_configure() {
	for plugin in ${PLUGINS}; do
		if use ${plugin}; then
			CMAKE_USE_DIR="${WORKDIR}/kdevelop-${plugin}-${PV}"
			kde4-base_src_configure
		fi
	done
}

src_compile() {
	for plugin in ${PLUGINS}; do
		if use ${plugin}; then
			CMAKE_USE_DIR="${WORKDIR}/kdevelop-${plugin}-${PV}"
			kde4-base_src_compile
		fi
	done
}

src_install() {
	for plugin in ${PLUGINS}; do
		if use ${plugin}; then
			CMAKE_USE_DIR="${WORKDIR}/kdevelop-${plugin}-${PV}"
			kde4-base_src_install
		fi
	done
}
