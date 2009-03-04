# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="KDE gpg keyring manager"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"

DEPEND="
	>=kde-base/kdepimlibs-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}
	app-crypt/gnupg
"
