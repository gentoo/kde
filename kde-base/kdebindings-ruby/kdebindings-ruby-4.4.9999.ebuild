# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebindings"
KMMODULE="ruby"
WEBKIT_REQUIRED="optional"

USE_RUBY="ruby18"

inherit kde4-meta ruby-ng

DESCRIPTION="KDE Ruby bindings"
KEYWORDS=""
IUSE="akonadi debug okular phonon plasma qscintilla qwt semantic-desktop"

DEPEND="
	$(add_kdebase_dep smoke 'akonadi?,okular?,phonon?,qscintilla?,qwt?,semantic-desktop?')
"

RDEPEND="${DEPEND}
	!dev-ruby/qt4-qtruby
"

KMEXTRACTONLY="
	ruby/krossruby
"

PATCHES=(
	"${FILESDIR}"/${PN}-fix-linkage.patch
)

pkg_setup() {
	ruby-ng_pkg_setup
	kde4-meta_pkg_setup
}

src_unpack() {
	kde4-meta_src_unpack

	cd "${WORKDIR}"
	mkdir all
	mv ${P} all/ || die "Could not move sources"
}

all_ruby_prepare() {
	kde4-meta_src_prepare

	sed -i -e "s#smoke/smoke.h#smoke.h#" \
		ruby/qtruby/src/handlers.cpp \
		ruby/qtruby/src/marshall.h \
		ruby/qtruby/src/marshall_types.h \
		ruby/qtruby/src/Qt.cpp \
		ruby/qtruby/src/qtruby.cpp \
		ruby/qtruby/src/qtruby.h \
		ruby/qtruby/src/smokeruby.h || die
}

each_ruby_configure() {
	CMAKE_USE_DIR=${S}
	mycmakeargs=(
		$(cmake-utils_use_with akonadi)
		$(cmake-utils_use_with akonadi KdepimLibs)
		$(cmake-utils_use_with okular)
		$(cmake-utils_use_enable plasma PLASMA_RUBY)
		$(cmake-utils_use_with phonon)
		$(cmake-utils_use_enable phonon PHONON_RUBY)
		$(cmake-utils_use_with qscintilla QScintilla)
		$(cmake-utils_use_enable qscintilla QSCINTILLA_RUBY)
		$(cmake-utils_use_enable qwt QWT_RUBY)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_enable semantic-desktop SOPRANO_RUBY)
		$(cmake-utils_use_enable webkit QTWEBKIT_RUBY)
		-DENABLE_KROSSRUBY=OFF
		-DRUBY_LIBRARY=$(ruby_get_libruby)
		-DRUBY_INCLUDE_PATH=$(ruby_get_hdrdir)
		-DRUBY_EXECUTABLE=${RUBY}
	)
	kde4-meta_src_configure
}

each_ruby_compile() {
	CMAKE_USE_DIR=${S}
	kde4-meta_src_compile
}

each_ruby_install() {
	CMAKE_USE_DIR=${S}
	kde4-meta_src_install
}
