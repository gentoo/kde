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
IUSE="akonadi +phonon plasma qimageblitz qscintilla semantic-desktop webkit"

DEPEND="
	dev-lang/mono
	$(add_kdebase_dep smoke 'akonadi?,phonon?,qimageblitz?,qscintilla?,semantic-desktop?,webkit?')
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
		$(cmake-utils_use_with akonadi)
		$(cmake-utils_use_with akonadi KdepimLibs)
		$(cmake-utils_use_disable plasma)
		$(cmake-utils_use_with phonon)
		$(cmake-utils_use_with qimageblitz QImageBlitz)
		$(cmake-utils_use_with qscintilla QScintilla)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_disable webkit QtWebKit)
	)
	kde4-meta_src_configure
}
