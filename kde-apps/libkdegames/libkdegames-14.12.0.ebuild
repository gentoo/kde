# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="Base library common to many KDE games"
KEYWORDS=" ~amd64 ~x86"
IUSE="debug"

DEPEND="
	media-libs/libsndfile
	media-libs/openal
"
RDEPEND="${DEPEND}
	!<kde-base/kbreakout-4.10.50:4
"

KMSAVELIBS="true"
