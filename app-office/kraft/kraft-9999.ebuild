# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KDE_HANDBOOK="forceoptional"
inherit kde5
EGIT_REPO_URI="https://github.com/dragotin/kraft"
EGIT_BRANCH="kf5"

DESCRIPTION="Software to manage quotes and invoices in small enterprises"
HOMEPAGE="http://www.volle-kraft-voraus.de/"

KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kemoticons)
	$(add_frameworks_dep kglobalaccel)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knotifyconfig)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwallet)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep sonnet)
	$(add_kdeapps_dep akonadi)
	$(add_kdeapps_dep akonadi-contacts)
	$(add_kdeapps_dep kcontacts)
	$(add_qt_dep qtconcurrent)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtsql)
	$(add_qt_dep qtwebengine 'widgets')
	$(add_qt_dep qtwidgets)
	dev-cpp/ctemplate
"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS Changes.txt README Releasenotes.txt TODO )
