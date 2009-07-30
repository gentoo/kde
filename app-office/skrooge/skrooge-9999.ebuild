# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/office"
inherit kde4-base

DESCRIPTION="personal finances manager for KDE4, aiming at being simple and intuitive"
HOMEPAGE="http://www.kde-apps.org/content/show.php/skrooge?content=92458"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug"

DEPEND="dev-libs/libofx
	app-crypt/qca:2"
