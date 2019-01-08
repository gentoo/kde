# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KDE_AUTODEPS="false"
inherit kde5

DESCRIPTION="Client application for paste.kde.org"
HOMEPAGE="https://cgit.kde.org/cutepaste.git"

LICENSE="GPL-2"
KEYWORDS=""

DEPEND="
	$(add_qt_dep qtcore)
	$(add_qt_dep qtnetwork)
"
RDEPEND="${DEPEND}"
