# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

FRAMEWORKS_MINIMAL="5.19.0"
KDE_DOC_DIR="docs"
KDE_HANDBOOK="true"
KDE_TEST="true"
KMNAME="kdepimlibs"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="Kioslave plugins for various PIM apps"
KEYWORDS="~amd64 ~arm ~x86"
LICENSE="LGPL-2.1"
IUSE="ssl"

COMMON_DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_kdeapps_dep kldap)
	$(add_kdeapps_dep kmbox)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtwidgets)
	ssl? ( dev-libs/cyrus-sasl )
"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPEND}
	!kde-apps/kdepimlibs:4
	!kde-apps/kdepimlibs:5
"

if [[ ${KDE_BUILD_TYPE} = live ]] ; then
	S="${WORKDIR}/${P}/kioslave"
else
	S="${WORKDIR}/${KMNAME}-${PV}/kioslave"
fi

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package ssl Sasl2)
	)
	kde5_src_configure
}
