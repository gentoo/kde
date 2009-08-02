# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeaccessibility"

inherit kde4-meta

DESCRIPTION="KDE text-to-speech"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="alsa debug +handbook"

DEPEND="
	alsa? ( media-libs/alsa-lib )
"
RDEPEND="${DEPEND}"

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

pkg_postinst() {
	kde4-meta_pkg_postinst

	elog "To use KTTSD, you will need to install at least one of the following"
	elog "packages:"
	elog " - app-accessibility/epos"
	elog " - app-accessibility/festival"
	elog " - app-accessibility/flite"
	elog " - app-accessibility/freetts"
	elog " - app-accessibility/mbrola"
}
