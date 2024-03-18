# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_QTHELP="true"
KDE_ORG_CATEGORY="maui"
KFMIN=5.82.0
QTMIN=5.15.5
inherit ecm kde.org

DESCRIPTION="Maui Manager Library. Server and public library API."

LICENSE="LGPL-3"
SLOT="5"
KEYWORDS=""
IUSE=""

DEPEND="
	>=dev-qt/qtdbus-${QTMIN}:5
"
RDEPEND="${DEPEND}
"
