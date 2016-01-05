# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools pam

DESCRIPTION="The systemd project's logind, extracted to a standalone package"
HOMEPAGE="https://github.com/andywingo/elogind"
SRC_URI="https://github.com/andywingo/elogind/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="pam policykit"

DEPEND="
	sys-libs/libcap
	sys-apps/util-linux
	sys-apps/dbus
	pam? ( sys-libs/pam )
	policykit? ( sys-auth/polkit )
	"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-lrt.patch" )

src_prepare() {
	epatch ${PATCHES[@]}
	eautoreconf
}
