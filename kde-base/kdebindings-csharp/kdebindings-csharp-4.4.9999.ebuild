# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdebindings"
KMMODULE="csharp"
WEBKIT_REQUIRED="optional"
inherit kde4-meta mono

DESCRIPTION="C# bindings for KDE and Qt"
KEYWORDS=""
IUSE="akonadi +phonon plasma qimageblitz qscintilla semantic-desktop"

DEPEND="
	dev-lang/mono
	$(add_kdebase_dep smoke 'akonadi?,phonon?,qimageblitz?,qscintilla?,semantic-desktop?,webkit?')
	semantic-desktop? ( dev-libs/soprano[clucene] )
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="smoke/"

PATCHES=( "${FILESDIR}"/${PN}-4.4.1-make-stuff-optional.patch )

pkg_setup() {
	kde4-meta_pkg_setup

	if use plasma && ! use webkit; then
		eerror
		eerror "The plasma USE flag requires the webkit USE flag to be enabled."
		eerror
		eerror "Please enable webkit or disable plasma."
		die "plasma requires webkit"
	fi
}

src_prepare() {
	kde4-meta_src_prepare

	# Disable soprano index (clucene) bindings
	rm -f csharp/soprano/soprano/Soprano_Index_{CLuceneIndex,IndexFilterModel}.cs || die
	sed -e 's/\${SOPRANO_INDEX_LIBRARIES}//g' \
		-i csharp/soprano/CMakeLists.txt || die 'failed to remove clucene from link'

	sed -e "/add_subdirectory( examples )/ s:^:#:" \
		-i csharp/plasma/CMakeLists.txt || die 'failed to disable examples'
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with akonadi)
		$(cmake-utils_use_with akonadi KdepimLibs)
		$(cmake-utils_use_enable plasma PLASMA_SHARP)
		$(cmake-utils_use_enable phonon PHONON_SHARP)
		$(cmake-utils_use_enable qimageblitz QIMAGEBLITZ_SHARP)
		$(cmake-utils_use_enable qscintilla QSCINTILLA_SHARP)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_enable webkit QTWEBKIT_SHARP)
	)
	kde4-meta_src_configure
}
