# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="optional"
KDE_TEST="true"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="Multi-document editor with network transparency, Plasma integration and more"
HOMEPAGE="https://kde.org/applications/utilities/kate https://kate-editor.org/"

KEYWORDS=""
IUSE="activities +filebrowser lspclient +projects plasma +snippets sql"

DEPEND="
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtxml)
	activities? ( $(add_frameworks_dep kactivities) )
	filebrowser? ( $(add_frameworks_dep kbookmarks) )
	lspclient? ( $(add_frameworks_dep kitemmodels) )
	plasma? ( $(add_frameworks_dep plasma) )
	projects? (
		$(add_frameworks_dep knewstuff)
		$(add_frameworks_dep threadweaver)
	)
	snippets? ( $(add_frameworks_dep knewstuff) )
	sql? (
		$(add_frameworks_dep kwallet)
		$(add_qt_dep qtsql)
	)
"
RDEPEND="${DEPEND}
	!kde-misc/ktexteditorpreviewplugin
"

src_prepare() {
	kde5_src_prepare

	# delete colliding kwrite translations
	if [[ ${KDE_BUILD_TYPE} = release ]]; then
		find po -type f -name "*po" -and -name "kwrite*" -delete || die
		rm -rf po/*/docs/kwrite || die
	fi
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package activities KF5Activities)
		-DBUILD_filebrowser=$(usex filebrowser)
		-DBUILD_lspclient=$(usex lspclient)
		-DBUILD_sessionapplet=$(usex plasma)
		-DBUILD_project=$(usex projects)
		-DBUILD_snippets=$(usex snippets)
		-DBUILD_katesql=$(usex sql)
		-DBUILD_kwrite=FALSE
	)

	kde5_src_configure
}

src_test() {
	# tests hang
	local myctestargs=(
		-E "(session_manager_test|sessions_action_test)"
	)

	kde5_src_test
}

pkg_postinst() {
	kde5_pkg_postinst

	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		elog "The functionality of ktexteditorpreview plugin can be extended with:"
		elog "  kde-misc/kmarkdownwebview"
		elog "  media-gfx/kgraphviewer"
	fi
}
