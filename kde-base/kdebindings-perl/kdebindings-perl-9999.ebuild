# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebindings"
KMMODULE="perl"
MULTIMEDIA_REQUIRED="optional"
WEBKIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="KDE Perl bindings"
KEYWORDS=""
IUSE="debug plasma"

DEPEND="
	$(add_kdebase_dep smoke 'multimedia?,webkit?')
	>=dev-lang/perl-5.10.1
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_disable multimedia QtMultimedia)
		$(cmake-utils_use_disable plasma)
		$(cmake-utils_use_disable webkit QtWebKit)
	)
	kde4-meta_src_configure
}
