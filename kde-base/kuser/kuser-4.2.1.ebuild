# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeadmin"
inherit kde4-meta

DESCRIPTION="KDE user (/etc/passwd and other methods) manager"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"

DEPEND="
	>=kde-base/kdepimlibs-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}
	>=kde-base/knotify-${PV}:${SLOT}[kdeprefix=]
"
