# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="KDE library for playing & ripping CDs"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="alsa debug"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with alsa)
	)
	kde4-meta_src_configure
}
