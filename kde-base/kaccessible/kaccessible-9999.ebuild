# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KMNAME="kdeaccessibility"
inherit kde4-meta

DESCRIPTION="Provides accessibility services like focus tracking"
KEYWORDS=""
IUSE="debug +speechd"

DEPEND="app-accessibility/speech-dispatcher"
RDEPEND=${DEPEND}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with speechd Speechd)
	)
	kde4-meta_src_configure
}
