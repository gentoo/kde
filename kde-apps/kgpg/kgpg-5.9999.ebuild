# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_SELINUX_MODULE="gpg"
EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="Frontend for GnuPG, a powerful encryption utility by KDE"
HOMEPAGE="https://www.kde.org/applications/utilities/kgpg
https://utils.kde.org/projects/kgpg"
KEYWORDS=""
IUSE=""

CDEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep akonadi)
	$(add_kdeapps_dep akonadi-contact)
	$(add_kdeapps_dep kcontacts)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtprintsupport)
	$(add_qt_dep qtwidgets)
"
DEPEND="${CDEPEND}
	sys-devel/gettext
"
RDEPEND="${CDEPEND}
	app-crypt/gnupg
"

pkg_postinst() {
	kde5_pkg_postinst

	if ! has_version 'app-crypt/dirmngr' && ! has_version '>=app-crypt/gnupg-2.1'; then
		elog "For improved key search functionality, install app-crypt/dirmngr."
	fi
}
