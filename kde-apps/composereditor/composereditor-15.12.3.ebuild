# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

MY_PN="${PN}-ng"
KDE_TEST="false"
KMNAME="kdepim"
inherit kde5

DESCRIPTION="Composer editor for KDE PIM"
LICENSE="LGPL-2+"
KEYWORDS=" ~amd64 ~x86"
IUSE=""

COMMON_DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kdewebkit)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep sonnet)
	$(add_kdeapps_dep akonadi-mime)
	$(add_kdeapps_dep kmime)
	$(add_kdeapps_dep kpimtextedit)
	$(add_kdeapps_dep libakonadi)
	$(add_kdeapps_dep pimcommon)
	$(add_qt_dep designer)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtprintsupport)
	$(add_qt_dep qtwebkit)
	$(add_qt_dep qtwidgets)
"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPEND}
	!<kde-apps/kdepim-15.08.50:5
	!kde-apps/kdepim-common-libs:4
"

src_prepare() {
	if [[ ${KDE_BUILD_TYPE} = live ]] ; then
		S="${WORKDIR}/${P}/${PN}"
		mv "${WORKDIR}/${P}/${MY_PN}" "${S}" \
			|| die "Failed to prepare source directory"
	else
		S="${WORKDIR}/${KMNAME}-${PV}/${PN}"
		mv "${WORKDIR}/${KMNAME}-${PV}/${MY_PN}" "${S}" \
			|| die "Failed to prepare source directory"
	fi

	kde5_src_prepare
}
