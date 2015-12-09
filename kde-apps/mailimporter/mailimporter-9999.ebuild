# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_TEST="true"
inherit kde5

DESCRIPTION="Library to import mail from various sources"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_kdeapps_dep akonadi-contact)
	$(add_kdeapps_dep akonadi-mime)
	$(add_kdeapps_dep kmime)
	$(add_kdeapps_dep libakonadi)
	$(add_kdeapps_dep libkdepim)
	dev-qt/designer:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPEND}
	!<kde-apps/kdepim-15.08.50:5
	!kde-base/kdepim-common-libs:4
"
