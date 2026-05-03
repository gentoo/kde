# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
inherit ecm frameworks.kde.org

DESCRIPTION="Libary for handling mail messages and newsgroup articles"

LICENSE="LGPL-2 LGPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="=kde-frameworks/kcodecs-${KDE_CATV}*:6"
RDEPEND="${DEPEND}
	!kde-apps/kmime:5
"

CMAKE_SKIP_TESTS=(
	# bug 924507
	kmime-{header,message}test
)
