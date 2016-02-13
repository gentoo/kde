# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit kde5

DESCRIPTION="KDE PIM runtime plugin collection"
KEYWORDS=""
IUSE="google"

# TODO kolab, Qt5TextToSpeech

CDEPEND="
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemmodels)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep knotifyconfig)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwallet)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep akonadi)
	$(add_kdeapps_dep akonadi-calendar)
	$(add_kdeapps_dep akonadi-contact)
	$(add_kdeapps_dep akonadi-mime)
	$(add_kdeapps_dep akonadi-notes)
	$(add_kdeapps_dep akonadi-socialutils)
	$(add_kdeapps_dep kalarmcal)
	$(add_kdeapps_dep kcalcore)
	$(add_kdeapps_dep kcalutils)
	$(add_kdeapps_dep kcontacts)
	$(add_kdeapps_dep kidentitymanagement)
	$(add_kdeapps_dep kimap)
	$(add_kdeapps_dep kmailtransport)
	$(add_kdeapps_dep kmbox)
	$(add_kdeapps_dep kmime)
	$(add_kdeapps_dep libakonadi)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtxml)
	$(add_qt_dep qtxmlpatterns)
	dev-libs/libical:=
"
DEPEND="${CDEPEND}
	$(add_frameworks_dep kross)
	dev-libs/cyrus-sasl:2
	dev-libs/libxml2:2
	dev-libs/libxslt
	sys-devel/gettext
	x11-misc/shared-mime-info
	google? ( >=net-libs/libkgapi-5.1.0:5 )
"
RDEPEND="${CDEPEND}
	!kde-apps/kdepim-runtime:4
	|| ( $(add_kdeapps_dep kdepim-icons) $(add_frameworks_dep oxygen-icons) )
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package google KF5GAPI)
	)

	kde5_src_configure
}
