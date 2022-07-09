# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=5.96.0
QTMIN=5.15.4
inherit ecm kde.org

DESCRIPTION="Library to support mobipocket ebooks"

LICENSE="GPL-2" # TODO: CHECK
SLOT="5"
KEYWORDS=""
IUSE=""

DEPEND=">=dev-qt/qtgui-${QTMIN}:5"
RDEPEND="${DEPEND}"
