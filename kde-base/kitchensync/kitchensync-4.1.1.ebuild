# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2_pre1"

KMNAME=kdepim
inherit kde4-meta

DESCRIPTION="KDE Synchronisation Framework"
KEYWORDS="~amd64"
IUSE="debug htmlhandbook"

DEPEND=">=app-pda/libopensync-0.30
	dev-libs/glib:2
	>=kde-base/libkdepim-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

# xml targets from kmail are being uncommented by kde4-meta.eclass
KMEXTRACTONLY="libkdepim"
KMLOADLIBS="libkdepim"

pkg_postinst() {
	kde4-meta_pkg_postinst
	echo
	elog "kitchensync uses libopensync plugins to sync resources."
	elog "Install at least one of these to install with those resources."
	echo
	elog ">=app-pda/libopensync-plugin-evolution2-0.30"
	elog ">=app-pda/libopensync-plugin-file-0.30"
	elog ">=app-pda/libopensync-plugin-gnokii-0.30"
	elog ">=app-pda/libopensync-plugin-google-calendar-0.30"
	elog ">=app-pda/libopensync-plugin-gpe-0.30"
	elog ">=app-pda/libopensync-plugin-irmc-0.30"
	elog ">=app-pda/libopensync-plugin-kdepim-0.30"
	elog ">=app-pda/libopensync-plugin-palm-0.30"
	elog ">=app-pda/libopensync-plugin-python-0.30"
	elog ">=app-pda/libopensync-plugin-syncml-0.30"
	elog ">=app-pda/libopensync-plugin-vformat-0.30"
	echo
}
