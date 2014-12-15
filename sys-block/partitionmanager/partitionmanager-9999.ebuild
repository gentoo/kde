# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="true"
inherit kde5

DESCRIPTION="KDE utility for management of partitions and file systems"
HOMEPAGE="https://www.kde.org/applications/system/kdepartitionmanager/"

LICENSE="GPL-2 GPL-3"
SLOT="5"
KEYWORDS=""
IUSE="btrfs fat hfs jfs ntfs reiserfs reiser4 xfs zfs"

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep kwidgetsaddons)
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"
RDEPEND="${DEPEND}
	dev-libs/libatasmart
	>=sys-block/parted-3
	sys-apps/util-linux
	!sys-block/partitionmanager:0
	btrfs? ( sys-fs/btrfs-progs )
	fat? ( sys-fs/dosfstools )
	hfs? (
		sys-fs/diskdev_cmds
		virtual/udev
		sys-fs/hfsutils )
	jfs? ( sys-fs/jfsutils )
	ntfs? ( sys-fs/ntfs3g[ntfsprogs] )
	reiserfs? ( sys-fs/reiserfsprogs )
	reiser4? ( sys-fs/reiser4progs )
	xfs? ( sys-fs/xfsprogs )
	zfs? ( sys-fs/zfs )
"
