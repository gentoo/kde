# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcontrol/kcontrol-4.2.1.ebuild,v 1.4 2009/03/15 14:21:36 scarabeus Exp $

EAPI="2"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="The KDE Control Center"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

RDEPEND="
	!kdeprefix? ( !kde-base/ksmserver:4.1[-kdeprefix] )
	>=kde-base/kdnssd-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/khotkeys-${PV}:${SLOT}[kdeprefix=]
"
