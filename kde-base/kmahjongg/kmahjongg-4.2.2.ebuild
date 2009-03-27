# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmahjongg/kmahjongg-4.2.1.ebuild,v 1.2 2009/03/08 13:47:14 scarabeus Exp $

EAPI="2"

KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="Mahjongg for KDE"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	>=kde-base/libkmahjongg-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	libkdegames/
	libkmahjongg/
"
