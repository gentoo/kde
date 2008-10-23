# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME=kdeaccessibility
inherit kde4-meta

DESCRIPTION="KDE text-to-speech subsystem"
KEYWORDS="~amd64 ~x86"
IUSE="alsa debug htmlhandbook +ktts +phonon"

COMMONDEPEND="
	ktts? (
		alsa? ( >=media-libs/alsa-lib-1.0.14a )
		phonon? ( media-sound/phonon )
	)
	>=kde-base/kcmshell-${PV}:${SLOT}
	>=kde-base/knotify-${PV}:${SLOT}"
DEPEND="${DEPEND} ${COMMONDEPEND}"
RDEPEND="${RDEPEND} ${COMMONDEPEND}
	ktts? (
		app-accessibility/festival
		app-accessibility/epos
		app-accessibility/freetts
		app-accessibility/flite
	)"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with alsa Alsa)
		-DKDE4_KTTSD_PHONON=$(use phonon && echo OFF || echo ON)
		-DKDE4_KTTSD_ALSA=$(use alsa && echo ON || echo OFF)
		$(cmake-utils_use_with ktts Kttsmodule)"

	kde4-meta_src_configure
}
