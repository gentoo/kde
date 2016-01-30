# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_TEST=true
KMNAME=kdepimlibs
inherit kde5

DESCRIPTION="Library for akonadi notes integration"
KEYWORDS=""
LICENSE="LGPL-2.1"
IUSE=""

# some akonadi tests time out, that probably needs more work as it's ~700 tests
RESTRICT="test"

COMMON_DEPEND="
	$(add_frameworks_dep ki18n)
	$(add_kdeapps_dep kmime)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtxml)
"
DEPEND="${COMMON_DEPEND}
	$(add_kdeapps_dep akonadi)
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPEND}
	!kde-apps/kdepimlibs
"

if [[ ${KDE_BUILD_TYPE} = live ]] ; then
	S="${WORKDIR}/${P}/${PN}"
fi

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build test TESTING)
	)
	kde5_src_configure
}
