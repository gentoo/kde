# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="4.1"
KDE_LINGUAS="de"
inherit kde4-base

DESCRIPTION="Nice partition tool for KDE"
HOMEPAGE="http://www.kde-apps.org/content/show.php/KDE+Partition+Manager?content=89595"
SRC_URI="mirror://sourceforge/partitionman/${P/_alpha/-ALPHA}.tar.bz2"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"/${P/_alpha/-ALPHA}

DEPEND=">=kde-base/kdelibs-4.1.1
	sys-apps/parted
	sys-devel/gettext"

PREFIX="${KDEPREFIX}"
