# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="playground/devtools"
KMMODULE="kdevelop4-extra-plugins"
inherit kde4-base

DESCRIPTION="Various experimental plugins for kdevelop (support for other langs)"
HOMEPAGE="http://www.kdevelop.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="4"
KEYWORDS=""

PLUGINS="+bazaar +controlflowgraph +css
	+ctest +duchainviewer +erlang +executebrowser +executescript +gettersetter +git
	+includemanager +preprocessor
	+qtdesigner +ruby +sloc +sql +uistrings +valgrind +vcsprojectintegration"

#
# configure phase failed (on my box, missing cmake modules, missing deps)
# check coverage crossfire csharp java okteta teamwork veritascpp xdebug xml xtest
#
# compile phase failed (most look like c++ issues that may have worked in earlier gcc versions)
# automake cppunit python qmake
#
# install phase failed (no target install)
# mercurial metrics
#

IUSE="debug ${PLUGINS}"
PLUGINS="${PLUGINS//+/}"

DEPEND="
	>=dev-util/kdevelop-${PV}:${SLOT}
"
RDEPEND="${DEPEND}"

src_prepare() {
	for plugin in ${PLUGINS}; do
		if use ${plugin}; then
			CMAKE_USE_DIR="${WORKDIR}/${P}/${plugin}"
			sed -i -e '/^project(/afind_package(Qt4 REQUIRED)\n' "$CMAKE_USE_DIR/CMakeLists.txt"
		fi
	done
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
