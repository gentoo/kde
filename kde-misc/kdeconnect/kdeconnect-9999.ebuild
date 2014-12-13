# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_BRANCH="frameworks"
MY_PN=${PN}-kde
KMNAME=${MY_PN}

inherit kde5

DESCRIPTION="Adds communication between KDE and your smartphone"
HOMEPAGE="http://www.kde.org/"

KEYWORDS=""

LICENSE="GPL-2+"

DEPEND="
	app-crypt/qca:2[qt5,openssl]
	x11-libs/libfakekey
"
RDEPEND="${DEPEND}
	$(add_kdeplasma_dep plasma-workspace)
	net-dns/avahi
"

[[ ${KDE_BUILD_TYPE} != live ]] && S=${WORKDIR}/${MY_P}

pkg_postinst(){
	elog
	elog "Optional dependency:"
	elog "sys-fs/sshfs-fuse (for 'remote filesystem browser' plugin)"
	elog
	elog "The Android .apk file is available via"
	elog "https://play.google.com/store/apps/details?id=org.kde.kdeconnect_tp"
	elog
}
