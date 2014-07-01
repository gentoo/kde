# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_PN=${PN}-kde
DECLARATIVE_REQUIRED="always"
inherit kde4-base

if [[ ${KDE_BUILD_TYPE} != live ]]; then
	MY_P=${MY_PN}-${PV}
	SRC_URI="mirror://kde/unstable/${PN}/${PV}/src/${MY_P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
else
	EGIT_REPO_URI="git://anongit.kde.org/${MY_PN}"
	KEYWORDS=""
fi

DESCRIPTION="Adds communication between KDE and your smartphone"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2+"
SLOT="4"
IUSE="debug"

DEPEND="
	app-crypt/qca:2
	dev-libs/qjson
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep plasma-workspace)
	app-crypt/qca-ossl:2
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
