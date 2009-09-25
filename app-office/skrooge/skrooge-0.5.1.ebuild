# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="personal finances manager for KDE4, aiming at being simple and intuitive"
HOMEPAGE="http://www.kde-apps.org/content/show.php/skrooge?content=92458"
SRC_URI="http://websvn.kde.org/*checkout*/tags/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

DEPEND="dev-libs/libofx
	app-crypt/qca:2
	x11-libs/qt-sql[sqlite]"
