# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_TEST="true"
KMNAME="kdepimlibs"
inherit kde5

DESCRIPTION="Library for social utils integration"
KEYWORDS=" ~amd64 ~x86"
LICENSE="LGPL-2.1"
IUSE=""

# some akonadi tests time out, that probably needs more work as it's ~700 tests
RESTRICT="test"

COMMON_DEPEND="
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemmodels)
	$(add_kdeapps_dep libakonadi)
	$(add_qt_dep qtgui)
	x11-misc/shared-mime-info
"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPEND}
	!kde-apps/kdepimlibs:4
	!kde-apps/kdepimlibs:5
"

if [[ ${KDE_BUILD_TYPE} = live ]] ; then
	S="${WORKDIR}/${P}/${PN}"
else
	S="${WORKDIR}/${KMNAME}-${PV}/${PN}"
fi
