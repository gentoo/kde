# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_TEST="false"
KMNAME="kdepim"
inherit kde5

DESCRIPTION="Grantlee templating for kaddressbook"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE="prison"

COMMON_DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_kdeapps_dep akonadi-contact)
	$(add_kdeapps_dep grantleetheme)
	$(add_kdeapps_dep kcontacts)
	$(add_kdeapps_dep libakonadi)
	$(add_kdeapps_dep libkleo)
	dev-libs/grantlee:5
	dev-qt/designer:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	prison? ( media-libs/prison:5 )
"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPEND}
	!<kde-apps/kdepim-15.08.50:5
	!kde-base/kdepim-common-libs:4
"

S="${WORKDIR}/${P}/${PN}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package prison KF5Prison)
	)

	kde5_src_configure
}
