# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="optional"
ECM_QTHELP="false"
ECM_TEST="false"
PVCUT=$(ver_cut 1-2)
QTMIN=5.15.5
inherit ecm frameworks.kde.org

DESCRIPTION="Framework providing plugins to use KDE frameworks widgets in QtDesigner"

LICENSE="LGPL-2.1+"
KEYWORDS=""
IUSE=""

DEPEND="
	=kde-frameworks/kconfig-${PVCUT}*:5
	=kde-frameworks/kcoreaddons-${PVCUT}*:5
"
RDEPEND="${DEPEND}"
BDEPEND=">=dev-qt/linguist-tools-${QTMIN}:5"
