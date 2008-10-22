# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdebase-workspace
inherit kde4svn-meta

DESCRIPTION="A simple password checker, used by any software in need of user authentication."
KEYWORDS=""
IUSE="pam"

DEPEND="pam? ( >=kde-base/kdebase-pam-7
		sys-libs/pam )"
RDEPEND="${DEPEND}"

# PATCHES="${FILESDIR}/kdebase-${PV}-pam-optional.patch"

src_compile() {
	epatch "${FILESDIR}"/kdebase-4.0.82-pam-optional.patch
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with pam PAM)"

	kde4overlay-meta_src_compile
}
