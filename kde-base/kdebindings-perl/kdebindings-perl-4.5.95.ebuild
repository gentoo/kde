# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdebindings"
KMMODULE="perl"
DECLARATIVE_REQUIRED="optional"
MULTIMEDIA_REQUIRED="optional"
QTHELP_REQUIRED="optional"
WEBKIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="KDE Perl bindings"
KEYWORDS="~amd64 ~x86"
IUSE="akonadi attica debug kate okular phonon plasma qimageblitz qscintilla qwt semantic-desktop"

DEPEND="
	>=dev-lang/perl-5.10.1
	$(add_kdebase_dep smoke 'akonadi?,attica?,declarative?,kate?,multimedia?,okular?,phonon?,qimageblitz?,qscintilla?,qthelp?,qwt?,semantic-desktop?,webkit?')
	semantic-desktop? ( >=dev-libs/soprano-2.4.64 )
"
RDEPEND="${DEPEND}"

KMLOADLIBS="smoke"

KMEXTRACTONLY="
	smoke/
"

src_configure() {
	mycmakeargs=(
		-DDISABLE_Qt3Support=ON
		$(cmake-utils_use_with akonadi)
		$(cmake-utils_use_with akonadi KdepimLibs)
		$(cmake-utils_use_with attica LibAttica)
		$(cmake-utils_use_disable declarative QtDeclarative)
		$(cmake-utils_use_disable kate)
		$(cmake-utils_use_disable multimedia QtMultimedia)
		$(cmake-utils_use_with okular)
		$(cmake-utils_use_with phonon)
		$(cmake-utils_use_disable plasma)
		$(cmake-utils_use_with qimageblitz QImageBlitz)
		$(cmake-utils_use_with qscintilla QScintilla)
		$(cmake-utils_use_disable qthelp QtHelp)
		$(cmake-utils_use_disable qwt)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_disable webkit QtWebKit)
	)
	kde4-meta_src_configure
}
