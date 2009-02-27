# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkholidays/libkholidays-4.2.0.ebuild,v 1.2 2009/02/01 08:21:57 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KDE library to compute holidays."
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

src_test() {
	sed -i -e '/testlunar/ s/^/#DONOTRUNTEST /' "${S}"/${PN}/tests/CMakeLists.txt \
		|| die "sed to disable kcal-testlunar failed"

	kde4-meta_src_test
}
