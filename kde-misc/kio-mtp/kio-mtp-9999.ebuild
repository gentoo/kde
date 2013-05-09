# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="MTP KIO-Client for KDE"
HOMEPAGE="https://projects.kde.org/projects/playground/base/kio-mtp"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS=""
IUSE="debug"

DEPEND="
	>=media-libs/libmtp-1.1.3
"
RDEPEND="${DEPEND}"
