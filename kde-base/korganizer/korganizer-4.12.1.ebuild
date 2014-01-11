# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="A Personal Organizer for KDE"
HOMEPAGE="http://www.kde.org/applications/office/korganizer/"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep kdepim-common-libs)
	sys-libs/zlib
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep ktimezoned)
"

RESTRICT="test"
# bug 393135

KMLOADLIBS="kdepim-common-libs"

KMEXTRA="
	korgac/
"

KMEXTRACTONLY="
	akonadi_next/
	calendarviews/
	kdgantt2/
	kmail/
	pimcommon/
	knode/org.kde.knode.xml
	libkdepimdbusinterfaces/
	korgac/org.kde.korganizer.KOrgac.xml
"

KMCOMPILEONLY="
	incidenceeditor-ng/
	calendarsupport/
"

src_unpack() {
	if use kontact; then
		KMEXTRA="${KMEXTRA}
			kontact/plugins/planner/
			kontact/plugins/specialdates/
		"
	fi

	kde4-meta_src_unpack
}

src_install() {
	kde4-meta_src_install
	# colliding with kdepim-common-libs
	rm -rf "${ED}"/usr/share/kde4/servicetypes/calendarplugin.desktop
	rm -rf "${ED}"/usr/share/kde4/servicetypes/calendardecoration.desktop
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	if ! has_version kde-base/kdepim-kresources:${SLOT}; then
		echo
		elog "For groupware functionality, please install kde-base/kdepim-kresources:${SLOT}"
		echo
	fi
}
