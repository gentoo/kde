# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_QTHELP="false"
ECM_TEST="forceoptional"
KDE_ORG_NAME="kcmutils"
QTMIN=5.15.5
inherit ecm frameworks.kde.org

DESCRIPTION="CMake modules for KCMUtils and KCM desktop file generator"

LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="!<kde-frameworks/kcmutils-5.98.0"

src_configure() {
	local mycmakeargs=(
		-DTOOLS_ONLY=YES
	)
	ecm_src_configure
}
