# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdeedu
inherit kde4svn-meta

DESCRIPTION="KDE: letter order game."
KEYWORDS=""
IUSE="debug htmlhandbook"

DEPEND=">=kde-base/libkdeedu-${PV}:${SLOT}"
RDEPEND="${DEPEND}
	media-sound/phonon"

KMEXTRACTONLY="libkdeedu/kdeeduui libkdeedu/keduvocdocument"
