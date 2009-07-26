# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdetoys-meta/kdetoys-meta-4.2.4.ebuild,v 1.2 2009/06/04 23:49:50 alexxy Exp $

EAPI="2"

DESCRIPTION="KDE toys - merge this to pull in all kdetoys-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.3"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="kdeprefix"

RDEPEND="
	>=kde-base/amor-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kteatime-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/ktux-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kweather-${PV}:${SLOT}[kdeprefix=]
"
