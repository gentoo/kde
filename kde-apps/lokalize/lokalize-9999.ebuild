# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK=true
PYTHON_COMPAT=( python2_7 )
inherit python-single-r1 kde5

DESCRIPTION="KDE Applications 5 translation tool"
HOMEPAGE="http://www.kde.org/applications/development/lokalize
http://l10n.kde.org/tools"
KEYWORDS=""
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdoctools)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kross)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep sonnet)
	>=app-text/hunspell-1.2.8
	dev-qt/qtdbus:5
	dev-qt/qtscript:5
	dev-qt/qtsql:5[sqlite]
	dev-qt/qtwidgets:5
"
RDEPEND="${DEPEND}
	$(add_kdeapps_dep pykde5 "${PYTHON_USEDEP}")
	dev-python/translate-toolkit[${PYTHON_USEDEP}]
	!kde-apps/lokalize:4
	!kde-base/lokalize
"

pkg_setup() {
	python-single-r1_pkg_setup
	kde5_pkg_setup
}

src_install() {
	kde5_src_install
	python_fix_shebang "${ED}/usr/share/${PN}"
}

pkg_postinst() {
	kde5_pkg_postinst

	if ! has_version dev-vcs/subversion ; then
		elog "To be able to autofetch KDE translations in new project wizard, install dev-vcs/subversion."
	fi
}
