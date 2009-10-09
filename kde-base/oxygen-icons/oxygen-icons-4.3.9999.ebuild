# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

if [[ ${PV} = *9999* ]]; then
	KMNAME="kdesupport"
else
	KMNAME="oxygen-icons"
fi
KDE_REQUIRED="never"
inherit kde4-base

DESCRIPTION="Oxygen SVG icon theme."
HOMEPAGE="http://www.oxygen-icons.org/"
#SRC_URI="mirror://kde/unstable/${PV}/src/${P}.tar.bz2"

LICENSE="LGPL-3"
KEYWORDS=""
IUSE=""

# Block conflicting packages
RDEPEND="
	!kdeprefix? (
		!<kde-base/kdebase-data-4.2.67:4.2[-kdeprefix]
		!<kde-base/kdebase-data-4.2.67:4.3[-kdeprefix]
		!<=kde-base/kdepim-icons-4.2.89[-kdeprefix]
		!<kde-base/kmail-4.3.2:4.3[-kdeprefix]
		!<=kde-base/step-4.2.98[-kdeprefix]
	)
	kdeprefix? (
		!<kde-base/kdebase-data-4.2.67:${SLOT}[kdeprefix]
		!<=kde-base/kdepim-icons-4.2.89:${SLOT}[kdeprefix]
		!<=kde-base/step-4.2.98:${SLOT}[kdeprefix]
		!<kde-base/kmail-4.3.2:${SLOT}[kdeprefix]
	)
"
