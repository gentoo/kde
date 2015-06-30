# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kabcclient/kabcclient-4.4.11.1.ebuild,v 1.9 2014/04/05 17:55:53 dilfridge Exp $

EAPI=5

KMNAME="kdepim"
KMMODULE="console/${PN}"
KDE_HANDBOOK=optional
inherit kde4-meta

DESCRIPTION="A command line client for accessing the KDE addressbook (noakonadi branch)"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs '' 4.6)
"
RDEPEND="${DEPEND}"

src_install() {
	kde4-meta_src_install

	# work around NULL DT_RPATH in kabc2mutt
	dosym kabcclient ${PREFIX}/bin/kabc2mutt || die "couldn't symlink kabc2mutt to kabcclient"
}
