# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="KDE library for playing & ripping CDs"
KEYWORDS=""
IUSE="alsa debug"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with alsa)
	)
	kde4-base_src_configure
}
