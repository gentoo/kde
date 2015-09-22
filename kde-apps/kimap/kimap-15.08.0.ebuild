# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_DOXYGEN="true"
KDE_TEST="true"
inherit kde5

DESCRIPTION="Library for interacting with IMAP servers"
LICENSE="LGPL-2+"
KEYWORDS="~amd64 ~x86"
IUSE=""

PATCHES=(
	"${FILESDIR}"/kimap-15.08.0-remove-kdelibs4support.patch
)

RDEPEND="
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_kdeapps_dep kmime)
	dev-libs/cyrus-sasl
	dev-qt/qtgui:5
"
DEPEND="${RDEPEND}
	dev-libs/boost
"
