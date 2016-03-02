# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_AUTODEPS="false"
inherit kde5

DESCRIPTION="Client application for paste.kde.org"
HOMEPAGE="https://projects.kde.org/projects/playground/network/cutepaste"

LICENSE="GPL-2"
KEYWORDS=""

DEPEND="
	$(add_qt_dep qtcore)
	$(add_qt_dep qtnetwork)
"
RDEPEND="${DEPEND}"
