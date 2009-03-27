# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkcompactdisc/libkcompactdisc-4.2.1.ebuild,v 1.1 2009/03/04 22:37:05 alexxy Exp $

EAPI="2"

KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="KDE library for playing & ripping CDs"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="alsa debug"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with alsa Alsa)"
	kde4-meta_src_configure
}
