# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Based in parts upon a work of individual contributors of the genkdesvn project

EAPI="2"

KMNAME="kdeaccessibility"
inherit kde4-meta

DESCRIPTION="KDE text-to-speech subsystem"
KEYWORDS="~alpha ~amd64 ~ia64 ~x86"
IUSE="alsa debug doc +ktts +phonon"

DEPEND="
	ktts? (
		alsa? ( >=media-libs/alsa-lib-1.0.14a )
		phonon? ( >=media-sound/phonon-4.3.1 )
	)
"
RDEPEND="${DEPEND}
	>=kde-base/kcmshell-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/knotify-${PV}:${SLOT}[kdeprefix=]
	ktts? (
		app-accessibility/epos
		app-accessibility/festival
		app-accessibility/flite
		app-accessibility/freetts
	)
"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with alsa Alsa)
		-DKDE4_KTTSD_PHONON=$(use phonon && echo OFF || echo ON)
		-DKDE4_KTTSD_ALSA=$(use alsa && echo ON || echo OFF)
		$(cmake-utils_use_with ktts Kttsmodule)"

	kde4-meta_src_configure
}
