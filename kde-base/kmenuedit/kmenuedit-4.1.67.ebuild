# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME=kdebase-workspace
inherit kde4-meta

DESCRIPTION="KDE menu editor"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

DEPEND="kde-base/khotkeys:${SLOT}"

src_configure() {
		mkdir -pv "${WORKDIR}"/${PN}_build/khotkeys/app/ || die "mkdir failed"
		ln -s ${KDEDIR}/share/dbus-1/interfaces/org.kde.khotkeys.xml \
			"${WORKDIR}"/${PN}_build/khotkeys/app/org.kde.khotkeys.xml \
				|| die "symlinking xml file failed"
		
		kde4overlay-meta_src_compile
}

