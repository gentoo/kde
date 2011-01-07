# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="playground/sysadmin"
inherit kde4-base

DESCRIPTION="KDE-based PackageKit frontend"
HOMEPAGE="http://www.kde-apps.org/content/show.php/show.php?content=84745"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="
	>=app-admin/packagekit-0.6.8[qt4]
"
RDEPEND="${DEPEND}"
