# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
PVCUT=$(ver_cut 1-2)
QTMIN=5.15.5
inherit ecm frameworks.kde.org

DESCRIPTION="Framework providing client-side support for the XML-RPC protocol"

LICENSE="BSD-2"
KEYWORDS=""
IUSE=""

DEPEND="
	>=dev-qt/qtxml-${QTMIN}:5
	=kde-frameworks/kcoreaddons-${PVCUT}*:5
	=kde-frameworks/ki18n-${PVCUT}*:5
	=kde-frameworks/kio-${PVCUT}*:5
"
RDEPEND="${DEPEND}"
