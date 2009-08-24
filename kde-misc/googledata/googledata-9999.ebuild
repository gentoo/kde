# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: kde-misc/googledata-9999 $

EAPI="2"

KMNAME="extragear/pim"
inherit kde4-base

DESCRIPTION="Google contacts and calendar akonadi resource"
HOMEPAGE="http://pim.kde.org/akonadi/"

SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=kde-base/akonadi-${KDE_MINIMAL}
		>=net-libs/libgcal-0.9.0"
RDEPEND="${DEPEND}"

