# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DECLARATIVE_REQUIRED="always"
OPENGL_REQUIRED="always"
KDE_LINGUAS="ca cs da de es fi fr gl hu lv nl pt pt_BR sk sl sv uk zh_TW"
inherit kde4-base

DESCRIPTION="Unified media experience for any device capable of running KDE"
HOMEPAGE="http://www.kde.org/ http://community.kde.org/Plasma/Plasma_Media_Center"

if [[ ${KDE_BUILD_TYPE} != live ]]; then
	SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"
	S=${WORKDIR}/${PN}
fi

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""
IUSE="debug"

# bug 516686
RESTRICT="test"

DEPEND="
	$(add_kdebase_dep nepomuk-core)
	$(add_kdebase_dep plasma-workspace)
	dev-qt/qt-mobility[multimedia,qml]
	media-libs/taglib
"
RDEPEND="${DEPEND}"
