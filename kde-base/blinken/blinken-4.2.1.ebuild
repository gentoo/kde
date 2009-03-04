# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeedu"
inherit kde4-meta

DESCRIPTION="KDE version of the Simon Says game."
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"

DEPEND="
	>=kde-base/libkdeedu-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}
	>=kde-base/knotify-${PV}:${SLOT}[kdeprefix=]
"

KMEXTRACTONLY="libkdeedu/kdeeduui"
