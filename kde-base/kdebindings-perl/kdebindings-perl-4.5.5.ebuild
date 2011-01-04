# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebindings"
KMMODULE="perl"
MULTIMEDIA_REQUIRED="optional"
QTHELP_REQUIRED="optional"
WEBKIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="KDE Perl bindings"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="akonadi attica debug okular phonon plasma qimageblitz qscintilla qwt semantic-desktop"

DEPEND="
	>=dev-lang/perl-5.10.1
	$(add_kdebase_dep smoke 'akonadi?,attica?,multimedia?,okular?,phonon?,qimageblitz?,qscintilla?,qthelp?,qwt?,semantic-desktop?,webkit?')
	semantic-desktop? ( >=dev-libs/soprano-2.4.64 )
"
RDEPEND="${DEPEND}"

KMLOADLIBS="smoke"

src_configure() {
	mycmakeargs=(
		-DDISABLE_Qt3Support=ON
		$(cmake-utils_use_with akonadi)
		$(cmake-utils_use_with akonadi KdepimLibs)
		$(cmake-utils_use_with attica LibAttica)
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
