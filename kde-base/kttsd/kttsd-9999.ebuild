# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeaccessibility"

inherit kde4-meta

DESCRIPTION="KDE text-to-speech"
KEYWORDS=""
IUSE="alsa debug doc phonon"

DEPEND="
	alsa? ( media-libs/alsa-lib )
	phonon? ( >=media-sound/phonon-${PV} )
"
RDEPEND="${DEPEND}
	|| (
			app-accessibility/festival
			app-accessibility/flite
			app-accessibility/epos
			app-accessibility/freetts
			app-accessibility/mbrola
		)"

src_configure()
{
	mycmakeargs="${mycmakeargs}
		-DKDE4_KTTSD_ALSA=$(use alsa && echo ON || echo OFF)
		-DKDE4_KTTSD_PHONON=$(use phonon && echo ON || echo OFF)
		$(cmake-utils_use_with alsa Alsa)"

	kde4-meta_src_configure
}
