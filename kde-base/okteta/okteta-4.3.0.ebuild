# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="KDE hexeditor"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug +handbook"

DEPEND="
	app-crypt/qca:2
"
RDEPEND="${DEPEND}"

src_prepare() {
	kde4-meta_src_prepare

	# Remove compile-time dep on LibKNotificationItem
	sed -i -e '/LibKNotificationItem-1/s/^/#DONOTNEED /' CMakeLists.txt
}
