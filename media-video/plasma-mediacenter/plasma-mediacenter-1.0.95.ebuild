# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/plasma-mediacenter/plasma-mediacenter-1.0.0.ebuild,v 1.1 2013/07/10 19:33:44 dilfridge Exp $

EAPI=5

DECLARATIVE_REQUIRED="always"
OPENGL_REQUIRED="always"
inherit kde4-base

DESCRIPTION="Unified media experience for any device capable of running KDE"
HOMEPAGE="http://www.kde.org/"

if [[ ${KDE_BUILD_TYPE} != live ]]; then
	SRC_URI="mirror://kde/unstable/${PN}/${PV}/src/${P}.tar.bz2"
fi

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep nepomuk-core)
	dev-qt/qt-mobility[multimedia,qml]
	media-libs/taglib
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}
