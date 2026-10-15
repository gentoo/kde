# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KDE_ORG_CATEGORY="system"
KDE_VERIFY_SIG=1
KFMIN=6.23.0
QTMIN=6.8.0
inherit ecm kde.org

DESCRIPTION="Btrfs Filesystem snapshot integration for KDE applications"
HOMEPAGE="https://invent.kde.org/system/kio-snapshot"
SRC_URI="
	mirror://kde/stable/${PN}/${P}.tar.xz
	verify-sig? ( mirror://kde/stable/${PN}/${P}.tar.xz.sig )
"

LICENSE="CC-BY-SA-4.0 CC0-1.0 LGPL-2+"
SLOT="0"
KEYWORDS="~amd64"

# Tests require root access to create a btrfs loop device to test against
RESTRICT="test"

# kcoreaddon required due to use of kcoreaddons_add_plugin
DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	sys-apps/util-linux
	sys-fs/btrfs-progs:=
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_prepare() {
	cmake_src_prepare

	# Don't build tests unconditionally
	cmake_comment_add_subdirectory autotests
}
