# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdepim"
WEBKIT_REQUIRED="always"
inherit kde4-meta

DESCRIPTION="KDE PIM templateparser library"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs 'akonadi')
	$(add_kdebase_dep libkdepim)
	$(add_kdebase_dep libkpgp)
	$(add_kdebase_dep messagecore)
	$(add_kdebase_dep messageviewer)
"
RDEPEND="${DEPEND}"

add_blocker kmail 4.4.71

KMEXTRACTONLY="
	libkleo/
	libkpgp/
	messagecomposer/
	messagecore/
	messageviewer/
"

KMLOADLIBS="libkdepim messagecore"

src_install() {
	kde4-meta_src_install

	# install additional generated headers that are needed by other packages that
	# are derived from kdepim. e.g. kmail.
	pushd "${CMAKE_BUILD_DIR}/templateparser/" 2>/dev/null || die "pushd templateparser failed"
	insinto "${PREFIX}/include"
	doins ui_{customtemplates,templatesconfiguration}_base.h || die "Failed to install extra header files."
	popd 2>/dev/null
}
