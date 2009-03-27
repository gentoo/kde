# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktimetracker/ktimetracker-4.2.1.ebuild,v 1.2 2009/03/08 14:04:31 scarabeus Exp $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KTimeTracker tracks time spent on various tasks."
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	>=kde-base/kontact-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kdepim-kresources-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libkdepim-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	kresources/
"

KMLOADLIBS="libkdepim kontactinterfaces"
