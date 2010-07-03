# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebindings"
KMMODULE="ruby"
WEBKIT_REQUIRED="optional"

USE_RUBY="ruby18"
# No ruby19 for two reasons:
# 1) it does not build (yet) - solvable I'd guess
# 2) the ebuild can only be installed for one ruby variant, otherwise the compiled
#    files with identical path+name will overwrite each other - difficult :(

# Workaround to get things in principle build with several ruby implementations:
CMAKE_IN_SOURCE_BUILD=1

inherit kde4-meta ruby-ng

DESCRIPTION="KDE Ruby bindings"
KEYWORDS=""
IUSE="attica akonadi debug multimedia okular phonon qimageblitz qscintilla qwt semantic-desktop"

DEPEND="
	$(add_kdebase_dep smoke 'attica?,akonadi?,multimedia?,okular?,phonon?,qimageblitz?,qscintilla?,qwt?,semantic-desktop?')
"

RDEPEND="${DEPEND}
	!dev-ruby/qt4-qtruby
"

# Merged with kdebindings-ruby after 4.4.80
add_blocker krossruby

PATCHES=(
	"${FILESDIR}"/${PN}-fix-linkage-4.5.patch
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
		$(cmake-utils_use_with attica LibAttica)
		$(cmake-utils_use_with qimageblitz)
		$(cmake-utils_use_with qwt Qwt5)
		$(cmake-utils_use_with phonon)
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with akonadi KdepimLibs)
		$(cmake-utils_use_with akonadi)
		$(cmake-utils_use_with qscintilla QScintilla)
		$(cmake-utils_use_with okular)
		$(cmake-utils_use_with webkit QT_QTWEBKIT)
		$(cmake-utils_use_with multimedia QT_MULTIMEDIA)
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
