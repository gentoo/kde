# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_HANDBOOK=true
KDE_TEST=true
inherit kde5

DESCRIPTION="Personal Information Management Suite"
HOMEPAGE="https://www.kde.org/applications/office/kontact/"
KEYWORDS="~amd64 ~x86"

PIM_FTS="akonadiconsole akregator blogilo console kaddressbook kalarm kleopatra kmail knotes kontact korganizer ktnef"
IUSE="designer google prison $(printf 'kdepim_features_%s ' ${PIM_FTS})"

DEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kauth)
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep kdewebkit)
	$(add_frameworks_dep kdnssd)
	$(add_frameworks_dep kglobalaccel)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep khtml)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemmodels)
	$(add_frameworks_dep knewstuff)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep knotifyconfig)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwallet)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep kxmlrpcclient)
	$(add_frameworks_dep sonnet)
	$(add_kdeapps_dep akonadi)
	$(add_kdeapps_dep akonadi-calendar)
	$(add_kdeapps_dep akonadi-search)
	$(add_kdeapps_dep gpgmepp)
	$(add_kdeapps_dep kalarmcal)
	$(add_kdeapps_dep kblog)
	$(add_kdeapps_dep kcalcore)
	$(add_kdeapps_dep kcontacts)
	$(add_kdeapps_dep kdepimlibs)
	$(add_kdeapps_dep kholidays)
	$(add_kdeapps_dep kidentitymanagement)
	$(add_kdeapps_dep kimap)
	$(add_kdeapps_dep kldap)
	$(add_kdeapps_dep kmailtransport)
	$(add_kdeapps_dep kmbox)
	$(add_kdeapps_dep kmime)
	$(add_kdeapps_dep kontactinterface)
	$(add_kdeapps_dep kpimtextedit)
	$(add_kdeapps_dep ktnef)
	$(add_kdeapps_dep syndication)
	>=app-crypt/gpgme-1.3.2
	dev-libs/boost:=
	dev-libs/grantlee:5
	dev-libs/libxslt
	dev-qt/qtconcurrent:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtopengl:5
	dev-qt/qtscript:5
	dev-qt/qtsql:5
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	dev-qt/qtxml:5
	media-libs/phonon[qt5]
	sys-libs/zlib
	designer? ( dev-qt/designer:5 )
	google? ( net-libs/libkgapi:5 )
	prison? ( media-libs/prison:5 )
	kdepim_features_kleopatra? (
		dev-libs/libassuan
		dev-libs/libgpg-error
	)
"
RDEPEND="${DEPEND}
	!kde-base/akonadiconsole
	!kde-base/akregator
	!kde-base/blogilo
	!kde-base/calendarjanitor
	!kde-base/kabcclient
	!kde-base/kaddressbook
	!kde-base/kalarm
	!kde-base/kdepim-common-libs
	!kde-base/kdepim-icons
	!kde-base/kdepim-kresources
	!kde-base/kdepim-l10n
	!kde-base/kdepim-meta
	!kde-base/kdepim-runtime
	!kde-base/kjots
	!kde-base/kleopatra
	!kde-base/kmail
	!kde-base/knode
	!kde-base/knotes
	!kde-base/konsolekalendar
	!kde-base/kontact
	!kde-base/korganizer
	!kde-base/ktimetracker
	!kde-base/ktnef
	$(add_kdeapps_dep kdepim-runtime)
	kdepim_features_kleopatra? ( app-crypt/gnupg )
"
# kontact: summary plugin; kalarm: email scheduler
REQUIRED_USE="
	kdepim_features_kontact? ( kdepim_features_kmail )
	kdepim_features_kalarm? ( kdepim_features_kmail )
"

src_prepare() {
	kde5_src_prepare

	use handbook || sed -e '/^find_package.*KF5DocTools/ s/^/#/' \
		-i CMakeLists.txt || die

	# applications
	for pim_ft in ${PIM_FTS}; do
		use kdepim_features_${pim_ft} || comment_add_subdirectory ${pim_ft}
	done
}

src_configure() {
	local mycmakeargs=(
		-DKDEPIM_NO_TEXTTOSPEECH=TRUE
		$(cmake-utils_use_find_package designer Qt5Designer)
		$(cmake-utils_use_find_package google KF5GAPI)
		$(cmake-utils_use_find_package prison KF5Prison)
	)

	kde5_src_configure
}
