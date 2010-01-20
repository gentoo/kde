# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="A Personal Organizer for KDE"
KEYWORDS=""
IUSE="debug +handbook"

DEPEND="
	$(add_kdebase_dep kdepimlibs 'akonadi')
	$(add_kdebase_dep libkdepim)
	sys-libs/zlib
"
RDEPEND="${DEPEND}"

# Moved after 4.3.90
add_blocker kontact-specialdates

# Tests hang, last checked in 4.3.3
RESTRICT="test"

KMLOADLIBS="libkdepim"
KMEXTRA="kdgantt1"

# xml targets from kmail are being uncommented by kde4-meta.eclass
KMEXTRACTONLY="
	akonadi/
	kmail/
	knode/org.kde.knode.xml
	libkdepimdbusinterfaces/
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

src_prepare() {
	epatch "${FILESDIR}/fix-broken-gpgme-cmake-guard.diff"

	# Needs to be done this way
	kde4-meta_src_prepare
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	if ! has_version kde-base/kdepim-kresources:${SLOT}; then
		echo
		elog "For groupware functionality, please install kde-base/kdepim-kresources:${SLOT}"
		echo
	fi
}
