# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Based in parts upon a work of individual contributors of the genkdesvn project

EAPI="2"

KMNAME="kdeadmin"
inherit kde4-meta

DESCRIPTION="KSystemLog is a system log viewer for KDE."
KEYWORDS="~alpha ~amd64 ~ia64 ~x86"
IUSE="debug doc"

DEPEND="
	>=kde-base/kdepimlibs-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}"
