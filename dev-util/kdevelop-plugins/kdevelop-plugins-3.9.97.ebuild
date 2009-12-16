# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base versionator

TMPVER="beta2"
KDEVPLATFORM_PV="$(($(get_major_version)-3)).$(get_after_major_version)"
DESCRIPTION="PHP plugin for KDevelop 4."
HOMEPAGE="http://www.kdevelop.org/"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"

PLUGINS="+php +phpdocs"
IUSE="debug ${PLUGINS}"
PLUGINS="${PLUGINS//+/}"

for plugin in ${PLUGINS}; do
	SRC_URI+=" ${plugin}? ( mirror://kde/unstable/kdevelop/${PV}/src/kdevelop-${plugin}-${TMPVER}.tar.bz2 )"
done

DEPEND="
	>=dev-util/kdevplatform-${KDEVPLATFORM_PV}
"
RDEPEND="${DEPEND}"

src_prepare() {
	:
}

src_configure() {
	for plugin in ${PLUGINS}; do
		if use ${plugin}; then
			CMAKE_USE_DIR="${WORKDIR}/kdevelop-${plugin}-${TMPVER}"
			kde4-base_src_configure
		fi
	done
}

src_compile() {
	for plugin in ${PLUGINS}; do
		if use ${plugin}; then
			CMAKE_USE_DIR="${WORKDIR}/kdevelop-${plugin}-${TMPVER}"
			kde4-base_src_compile
		fi
	done
}

src_install() {
	for plugin in ${PLUGINS}; do
		if use ${plugin}; then
			CMAKE_USE_DIR="${WORKDIR}/kdevelop-${plugin}-${TMPVER}"
			kde4-base_src_install
		fi
	done
}
