# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit autotools eutils pam

DESCRIPTION="The systemd project's logind, extracted to a standalone package"
HOMEPAGE="https://github.com/wingo/elogind"
SRC_URI="https://github.com/wingo/elogind/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC0-1.0 LGPL-2.1+ public-domain"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="acl apparmor pam policykit selinux +seccomp"

COMMON_DEPEND="
	sys-libs/libcap
	sys-apps/util-linux
	virtual/libudev:=
	acl? ( sys-apps/acl )
	apparmor? ( sys-libs/libapparmor )
	pam? ( virtual/pam )
	seccomp? ( sys-libs/libseccomp )
	selinux? ( sys-libs/libselinux )
"
RDEPEND="${COMMON_DEPEND}
	sys-apps/dbus
	policykit? ( sys-auth/polkit )
	!sys-auth/systemd
"
DEPEND="${COMMON_DEPEND}
	dev-util/gperf
	dev-util/intltool
	sys-devel/libtool
	virtual/pkgconfig
"

DOCS=( NEWS README TODO )
PATCHES=(
	"${FILESDIR}/${PN}-docs.patch"
	"${FILESDIR}/${PN}-lrt.patch"
)

src_prepare() {
	default

	# launch elogind when called via dbus
	sed -i -e "s|/bin/false|/usr/libexec/elogind/elogind|" src/login/org.freedesktop.login1.service || die

	eautoreconf
}

src_configure() {
	econf \
		--with-pamlibdir=$(getpam_mod_dir) \
		$(use_enable acl) \
		$(use_enable apparmor) \
		$(use_enable pam) \
		$(use_enable seccomp) \
		$(use_enable selinux)
}

src_install() {
	default
	prune_libtool_files --modules
}
