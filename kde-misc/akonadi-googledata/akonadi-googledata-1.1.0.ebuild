# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit kde4-base

DESCRIPTION="Google contacts and calendar akonadi resource"
HOMEPAGE="http://pim.kde.org/akonadi/"
SRC_URI="http://libgcal.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="!kde-misc/googledata
	app-office/akonadi-server
	dev-libs/boost
	dev-libs/libxslt
	>=net-libs/libgcal-0.9.4"
RDEPEND="${DEPEND}"
