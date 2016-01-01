# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_HANDBOOK=true
KDE_TEST=true
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="Personal Information Management Suite"
HOMEPAGE="https://www.kde.org/applications/office/kontact/"
KEYWORDS="~amd64 ~x86"

PIM_FTS="akonadiconsole akregator blogilo console kaddressbook kalarm kleopatra kmail knotes kontact korganizer ktnef"
IUSE="designer google prison $(printf 'kdepim_features_%s ' ${PIM_FTS})"

COMMON_DEPEND="
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
	$(add_kdeapps_dep akonadi-contact)
	$(add_kdeapps_dep akonadi-mime)
	$(add_kdeapps_dep akonadi-notes)
	$(add_kdeapps_dep akonadi-search)
	$(add_kdeapps_dep akonadi-socialutils)
	$(add_kdeapps_dep calendarsupport)
	$(add_kdeapps_dep composereditor)
	$(add_kdeapps_dep eventviews)
	$(add_kdeapps_dep gpgmepp)
	$(add_kdeapps_dep grantleetheme)
	$(add_kdeapps_dep incidenceeditor)
	$(add_kdeapps_dep kaddressbookgrantlee)
	$(add_kdeapps_dep kalarmcal)
	$(add_kdeapps_dep kblog)
	$(add_kdeapps_dep kcalcore)
	$(add_kdeapps_dep kcontacts)
	$(add_kdeapps_dep kdepim-kioslaves)
	$(add_kdeapps_dep kdgantt2)
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
	$(add_kdeapps_dep libakonadi)
	$(add_kdeapps_dep libfollowupreminder)
	$(add_kdeapps_dep libgravatar)
	$(add_kdeapps_dep libkdepim)
	$(add_kdeapps_dep libkdepimdbusinterfaces)
	$(add_kdeapps_dep libkleo)
	$(add_kdeapps_dep libksieve)
	$(add_kdeapps_dep libsendlater)
	$(add_kdeapps_dep mailcommon)
	$(add_kdeapps_dep mailimporter)
	$(add_kdeapps_dep messagecomposer)
	$(add_kdeapps_dep messagecore)
	$(add_kdeapps_dep messagelist)
	$(add_kdeapps_dep messageviewer)
	$(add_kdeapps_dep pimcommon)
	$(add_kdeapps_dep syndication)
	$(add_kdeapps_dep templateparser)
	>=app-crypt/gpgme-1.3.2
	dev-libs/boost:=
	dev-libs/grantlee:5
	dev-libs/libxslt
	dev-qt/qtconcurrent:5
	dev-qt/qtdbus:5
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
	designer? ( dev-qt/designer:5 )
	google? ( net-libs/libkgapi:5 )
	prison? ( media-libs/prison:5 )
	kdepim_features_kleopatra? (
		dev-libs/libassuan
		dev-libs/libgpg-error
	)
	kdepim_features_knotes? (
		$(add_kdeapps_dep noteshared)
	)
"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
	test? (
		$(add_kdeapps_dep akonadi sqlite)
		$(add_kdeapps_dep libakonadi tools)
		dev-qt/qtsql:5[sqlite]
	)
"
RDEPEND="${COMMON_DEPEND}
	!kde-apps/akonadiconsole:4
	!kde-apps/akregator:4
	!kde-apps/blogilo:4
	!kde-apps/calendarjanitor:4
	!kde-apps/kabcclient:4
	!kde-apps/kaddressbook:4
	!kde-apps/kalarm:4
	!kde-apps/kdepim-icons:4
	!kde-apps/kdepim-runtime:4
	!kde-apps/kjots:4
	!kde-apps/kleopatra:4
	!kde-apps/kmail:4
	!kde-apps/knode:4
	!kde-apps/knotes:4
	!kde-apps/konsolekalendar:4
	!kde-apps/kontact:4
	!kde-apps/korganizer:4
	!kde-apps/ktimetracker:4
	!kde-apps/ktnef:4
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

	rm -r calendarsupport		\
		composereditor-ng	\
		eventviews		\
		grantleetheme		\
		incidenceeditor-ng	\
		kaddressbookgrantlee	\
		kdgantt2		\
		libfollowupreminder	\
		libgravatar		\
		libkdepim		\
		libkdepimdbusinterfaces	\
		libkleo			\
		libksieve		\
		libsendlater		\
		mailcommon		\
		mailimporter		\
		messagecomposer		\
		messagecore		\
		messagelist		\
		messageviewer		\
		noteshared		\
		pimcommon		\
		templateparser		\
		|| die "Failed to remove split libraries"

	use handbook || sed -e '/^find_package.*KF5DocTools/ s/^/#/' \
		-i CMakeLists.txt || die

	if ! use kdepim_features_knotes ; then
		sed -i \
			-e '/find_package(KF5NoteShared/ s/^/#DONT/' \
			CMakeLists.txt || die
		sed -i \
			-e '/add_subdirectory(notesagent)/ s/^/#DONT/' \
			agents/CMakeLists.txt || die
	fi

	# applications
	for pim_ft in ${PIM_FTS}; do
		use kdepim_features_${pim_ft} || comment_add_subdirectory ${pim_ft}
	done
}

src_configure() {
	local mycmakeargs=(
		-DKDEPIM_BUILD_WITH_INSTALLED_LIB=TRUE
		$(cmake-utils_use_find_package designer Qt5Designer)
		$(cmake-utils_use_find_package google KF5GAPI)
		$(cmake-utils_use_find_package prison KF5Prison)
	)

	kde5_src_configure
}
