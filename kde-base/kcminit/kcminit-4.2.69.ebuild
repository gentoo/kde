# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-workspace"
inherit kde4-meta

DESCRIPTION="KCMInit - runs startups initialization for Control Modules."
KEYWORDS="~alpha ~amd64 ~ia64 ~x86"
IUSE="debug"

DEPEND="
	>=kde-base/ksplash-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}"
