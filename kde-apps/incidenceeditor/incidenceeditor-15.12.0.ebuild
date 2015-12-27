# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MY_PN="${PN}-ng"
KDE_TEST="true"
KMNAME="kdepim"
inherit kde5

DESCRIPTION="Incidence editor for korganizer"
LICENSE="LGPL-2+"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemmodels)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep akonadi-calendar)
	$(add_kdeapps_dep akonadi-contact)
	$(add_kdeapps_dep akonadi-mime)
	$(add_kdeapps_dep calendarsupport)
	$(add_kdeapps_dep eventviews)
	$(add_kdeapps_dep kcalcore)
	$(add_kdeapps_dep kcalutils)
	$(add_kdeapps_dep kcontacts)
	$(add_kdeapps_dep kdgantt2)
	$(add_kdeapps_dep kidentitymanagement)
	$(add_kdeapps_dep kldap)
	$(add_kdeapps_dep kmailtransport)
	$(add_kdeapps_dep kmime)
	$(add_kdeapps_dep libakonadi)
	$(add_kdeapps_dep libkdepim)
	$(add_kdeapps_dep libkdepimdbusinterfaces)
	dev-qt/designer:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5
"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPEND}
	!<kde-apps/kdepim-15.08.50:5
	!kde-apps/kdepim-common-libs:4
"

if [[ ${KDE_BUILD_TYPE} = live ]] ; then
	S="${WORKDIR}/${P}/${MY_PN}"
else
	S="${WORKDIR}/${KMNAME}-${PV}/${MY_PN}"
fi
