# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcontrol/kcontrol-4.2.0-r1.ebuild,v 1.1 2009/02/04 18:44:40 scarabeus Exp $

EAPI="2"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="The KDE Control Center"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"

DEPEND="
	!<kde-base/ksmserver-${PV}:${SLOT}[kdeprefix=]
	!kdeprefix? ( !<kde-base/ksmserver-${PV}[-kdeprefix] )
	>=kde-base/kdnssd-${PV}:${SLOT}
	>=kde-base/khotkeys-${PV}:${SLOT}
	"
