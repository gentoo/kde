# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdebindings"
KMMODULE="csharp"
WEBKIT_REQUIRED="optional"
inherit kde4-meta mono

DESCRIPTION="C# bindings for KDE and Qt"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="akonadi debug +phonon plasma qimageblitz qscintilla semantic-desktop"

DEPEND="
	dev-lang/mono
	$(add_kdebase_dep smoke 'akonadi?,phonon?,qimageblitz?,qscintilla?,semantic-desktop?,webkit?')
	semantic-desktop? ( >=dev-libs/soprano-2.4.64[clucene] )
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	smoke/
"

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
