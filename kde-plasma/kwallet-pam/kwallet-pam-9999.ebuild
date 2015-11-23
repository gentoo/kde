# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_AUTODEPS="false"
inherit kde5 pam

DESCRIPTION="KWallet PAM module to not enter password again"

LICENSE="LGPL-2.1"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-libs/libgcrypt:0=
	virtual/pam
"
RDEPEND="${DEPEND}"

src_install() {
	dopammod "${BUILD_DIR}"/pam_kwallet5.so
}

pkg_postinst(){
	elog
	elog "1. Currently, the wallet name must be 'kdewallet'."
	elog "2. Also, use standard blowfish encryption, GnuPG does not work at this point."
	elog "3. To configure kwallet-pam with sddm, add two lines to /etc/pam.d/sddm:"
	elog " "
	elog "  auth	include		system-login"
	elog "> -auth	optional	pam_kwallet5.so"
	elog "  account	include		system-login"
	elog "  password	include		system-login"
	elog "  session	include		system-login"
	elog "> -session	optional	pam_kwallet5.so auto_start"
	elog
}
