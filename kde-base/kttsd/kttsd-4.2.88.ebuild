# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeaccessibility"

inherit kde4-meta

DESCRIPTION="KDE text-to-speech"
KEYWORDS="~amd64 ~x86"
IUSE="alsa debug +handbook"

DEPEND="
	alsa? ( media-libs/alsa-lib )
"
RDEPEND="${DEPEND}
	app-accessibility/epos
	app-accessibility/festival
	app-accessibility/flite
	app-accessibility/freetts
	app-accessibility/mbrola
"
src_configure() {
	# we enable all plugins
	mycmakeargs="${mycmakeargs}
		-DKDE4_KTTSD_COMMAND=ON
		-DKDE4_KTTSD_EPOS=ON
		-DKDE4_KTTSD_FESTIVAL=ON
		-DKDE4_KTTSD_FLITE=ON
		-DKDE4_KTTSD_FREETTS=ON
		-DKDE4_KTTSD_HADIFIX=ON
		-DKDE4_KTTSD_PHONON=ON
		$(cmake-utils_use alsa KDE4_KTTSD_ALSA)"

	kde4-meta_src_configure
}
