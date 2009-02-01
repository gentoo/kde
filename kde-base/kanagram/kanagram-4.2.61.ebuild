# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeedu"
inherit kde4-meta

DESCRIPTION="KDE: letter order game."
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

DEPEND="
	>=kde-base/libkdeedu-${PV}:${SLOT}
"

KMEXTRACTONLY="libkdeedu/kdeeduui libkdeedu/keduvocdocument"
