# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="KDE gpg keyring manager"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
"
RDEPEND="${DEPEND}
	app-crypt/gnupg
"

pkg_postinst() {
	kde4-meta_pkg_postinst

	if ! has_version app-crypt/dirmngr ; then
		elog "For improved key search functionality, install app-crypt/dirmngr."
	fi
}
