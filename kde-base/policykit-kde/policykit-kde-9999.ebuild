# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdebase-workspace"
KMMODULE="PolicyKit-kde"
inherit kde4-meta

DESCRIPTION="PolicyKit integration module for KDE."
KEYWORDS=""
LICENSE="GPL-2"
IUSE="debug"

DEPEND="
	>=sys-auth/policykit-qt-0.9.3
"
RDEPEND="${DEPEND}
	!kde-misc/policykit-kde
"
