# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="The KDE Control Center"
KEYWORDS=""
IUSE="debug htmlhandbook"

DEPEND="
	!<kde-base/ksmserver-${PV}:${SLOT}[kdeprefix=]
	!kdeprefix? ( !<kde-base/ksmserver-${PV}[kdeprefix=] )
	>=kde-base/kdnssd-${PV}:${SLOT}
"
