# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kttsd/kttsd-4.2.0.ebuild,v 1.2 2009/02/01 08:09:02 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdeaccessibility"
inherit kde4-meta

DESCRIPTION="KDE text-to-speech subsystem"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="alsa debug htmlhandbook +ktts +phonon"

DEPEND="
	>=kde-base/kcmshell-${PV}:${SLOT}
	>=kde-base/knotify-${PV}:${SLOT}
	ktts? (
		alsa? ( >=media-libs/alsa-lib-1.0.14a )
		phonon? ( >=media-sound/phonon-4.3.0 )
	)
"

RDEPEND="${DEPEND}
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
