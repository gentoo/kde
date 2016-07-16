# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_TEST="true"
QT_MINIMAL="5.6.0"
inherit kde5

DESCRIPTION="Library for akonadi notes integration"
KEYWORDS=""
LICENSE="GPL-2+"
IUSE=""

# some akonadi tests time out, that probably needs more work as it's ~700 tests
RESTRICT="test"

RDEPEND="
	$(add_frameworks_dep ki18n)
	$(add_kdeapps_dep kmime)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtxml)
"
DEPEND="${RDEPEND}
	$(add_kdeapps_dep akonadi)
"
