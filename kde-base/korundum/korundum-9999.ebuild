# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

OPENGL_REQUIRED="always"

USE_RUBY="ruby20"
# Only one ruby version is supported:
# 1) cmake bails when configuring twice or more - solved with CMAKE_IN_SOURCE_BUILD=1
# 2) the ebuild can only be installed for one ruby variant, otherwise the compiled
#    files with identical path+name will overwrite each other - difficult :(

inherit kde4-base ruby-ng

DESCRIPTION="KDE Ruby bindings"
KEYWORDS=""
IUSE="akonadi debug kate nepomuk okular"
HOMEPAGE="http://techbase.kde.org/Development/Languages/Ruby"

DEPEND="
	$(add_kdebase_dep qtruby 'ruby_targets_ruby20')
	$(add_kdebase_dep smokekde 'akonadi?,kate?,okular?,nepomuk?')
	$(add_kdebase_dep smokeqt)
"
RDEPEND="${DEPEND}
"

pkg_setup() {
	ruby-ng_pkg_setup
	kde4-base_pkg_setup
}

src_unpack() {
	local S="${WORKDIR}/${P}"
	kde4-base_src_unpack

	cd "${WORKDIR}"
	mkdir all
	mv ${P} all/ || die "Could not move sources"
}

all_ruby_prepare() {
	kde4-base_src_prepare
}

each_ruby_configure() {
	CMAKE_USE_DIR=${S}
	local mycmakeargs=(
		-DRUBY_LIBRARY=$(ruby_get_libruby)
		-DRUBY_INCLUDE_PATH=$(ruby_get_hdrdir)
		-DRUBY_EXECUTABLE=${RUBY}
		$(cmake-utils_use_with akonadi)
		$(cmake-utils_use_with akonadi KdepimLibs)
		$(cmake-utils_use_with nepomuk)
		$(cmake-utils_use_with nepomuk Soprano)
		$(cmake-utils_use_disable kate)
		$(cmake-utils_use_with okular)
	)
	kde4-base_src_configure
}

each_ruby_compile() {
	CMAKE_USE_DIR=${S}
	kde4-base_src_compile
}

each_ruby_install() {
	CMAKE_USE_DIR=${S}
	kde4-base_src_install
}
