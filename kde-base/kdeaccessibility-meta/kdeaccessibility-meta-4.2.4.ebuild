# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaccessibility-meta/kdeaccessibility-meta-4.2.3.ebuild,v 1.1 2009/05/06 23:01:17 scarabeus Exp $

EAPI="2"

DESCRIPTION="kdeaccessibility - merge this to pull in all kdeaccessiblity-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="kdebase"

RDEPEND="
	>=kde-base/kdeaccessibility-colorschemes-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kdeaccessibility-iconthemes-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kmag-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kmousetool-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kmouth-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kttsd-${PV}:${SLOT}[kdeprefix=]
"
# The following are disabled in CMakeLists.txt
# >=kde-base/kbstateapplet-${PV}:${SLOT} - kicker applet
# >=kde-base/ksayit-${PV}:${SLOT} - doesn't compile
