# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdm/kdm-4.2.2.ebuild,v 1.2 2009/04/17 06:49:30 alexxy Exp $

EAPI="2"

KMNAME="kdebase-workspace"
inherit kde4-meta

DESCRIPTION="KDE login manager, similar to xdm and gdm"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="consolekit debug doc kerberos pam"

DEPEND="
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXtst
	consolekit? (
		>=sys-apps/dbus-1.0.2
		sys-auth/consolekit
	)
	kerberos? ( virtual/krb5 )
	pam? (
		>=kde-base/kcheckpass-${PV}:${SLOT}[kdeprefix=]
		virtual/pam
	)
"
RDEPEND="${DEPEND}
	>=kde-base/kdepasswd-${PV}:${SLOT}[kdeprefix=]
	>=x11-apps/xinit-1.0.5-r2
	x11-apps/xmessage
"

KMEXTRACTONLY="
	kcontrol/kdm/
"
KMEXTRA="
	libs/kdm/
"

PATCHES=( "${FILESDIR}/kdebase-4.0.2-pam-optional.patch" )

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(use kerberos && echo "-DKDE4_KRB5AUTH=ON" || echo "-DKDE4_KRB5AUTH=OFF")
		$(cmake-utils_use_with pam PAM)
		$(cmake-utils_use_with consolekit CkConnector)"

	kde4-meta_src_configure
}

src_install() {
	export GENKDMCONF_FLAGS="--no-old --no-backup"

	kde4-meta_src_install

	# Customize the kdmrc configuration
	sed -i -e "s:^.*SessionsDirs=.*$:#&\nSessionsDirs=/usr/share/xsessions:" \
		"${D}"/${PREFIX}/share/config/kdm/kdmrc \
		|| die "Failed to set SessionsDirs correctly."

	# Don't install empty dir
	rmdir "${D}${KDEDIR}"/share/config/kdm/sessions
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	# Set the default kdm face icon if it's not already set by the system admin
	# because this is user-overrideable in that way, it's not in src_install
	if [[ ! -e "${ROOT}${KDEDIR}/share/apps/kdm/faces/.default.face.icon" ]];	then
		mkdir -p "${ROOT}${KDEDIR}/share/apps/kdm/faces"
		cp "${ROOT}${KDEDIR}/share/apps/kdm/pics/users/default1.png" \
			"${ROOT}${KDEDIR}/share/apps/kdm/faces/.default.face.icon"
	fi
	if [[ ! -e "${ROOT}${KDEDIR}/share/apps/kdm/faces/root.face.icon" ]]; then
		mkdir -p "${ROOT}${KDEDIR}/share/apps/kdm/faces"
		cp "${ROOT}${KDEDIR}/share/apps/kdm/pics/users/root1.png" \
			"${ROOT}${KDEDIR}/share/apps/kdm/faces/root.face.icon"
	fi

	if use consolekit; then
		echo
		elog "You have compiled 'kdm' with consolekit support. If you want to use kdm,"
		elog "make sure consolekit daemon is running and started at login time"
		elog
		elog "rc-update add consolekit default && /etc/init.d/consolekit start"
		echo
	fi
}
