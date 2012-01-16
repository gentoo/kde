# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KMNAME="kdebindings"
KMMODULE="csharp"
inherit kde4-meta mono

DESCRIPTION="C# bindings for KDE and Qt"
KEYWORDS=""
IUSE="akonadi debug +phonon plasma qimageblitz qscintilla semantic-desktop webkit"

DEPEND="
	dev-lang/mono
	$(add_kdebase_dep smoke 'akonadi?,phonon?,qimageblitz?,qscintilla?,semantic-desktop=,webkit?')
	semantic-desktop? ( >=dev-libs/soprano-2.6.51[clucene] )
"
RDEPEND="${DEPEND}"
REQUIRED_USE="plasma? ( webkit )"

KMEXTRACTONLY="
	smoke/
"

src_prepare() {
	kde4-meta_src_prepare

	sed -i "/add_subdirectory( examples )/ s:^:#:" csharp/plasma/CMakeLists.txt
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_disable akonadi)
		$(cmake-utils_use_disable phonon)
		$(cmake-utils_use_disable plasma)
		$(cmake-utils_use_disable qimageblitz QImageBlitz)
		$(cmake-utils_use_disable qscintilla QScintilla)
		$(cmake-utils_use_disable semantic-desktop Nepomuk)
		$(cmake-utils_use_disable semantic-desktop Soprano)
		$(cmake-utils_use_disable webkit QtWebKit)
	)
	kde4-meta_src_configure
}
