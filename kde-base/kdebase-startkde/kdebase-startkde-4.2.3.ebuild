# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-startkde/kdebase-startkde-4.2.2-r1.ebuild,v 1.2 2009/04/17 06:15:10 alexxy Exp $

EAPI="2"

KMNAME="kdebase-workspace"
KMNOMODULE="true"
inherit kde4-meta multilib

DESCRIPTION="Startkde script, which starts a complete KDE session, and associated scripts"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""

# The KDE apps called from the startkde script.
# These provide the most minimal KDE desktop.
RDEPEND="
	>=kde-base/kcminit-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kdebase-desktoptheme-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kdebase-kioslaves-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kdedglobalaccel-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kde-wallpapers-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/knotify-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kreadconfig-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/krunner-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/ksmserver-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/ksplash-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kstartupconfig-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kstyles-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kwin-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/phonon-kde-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/plasma-apps-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/plasma-workspace-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/systemsettings-${PV}:${SLOT}[kdeprefix=]
	x11-apps/mkfontdir
	x11-apps/xmessage
	x11-apps/xprop
	x11-apps/xrandr
	x11-apps/xrdb
	x11-apps/xsetroot
	x11-apps/xset
"

KMEXTRACTONLY="
	ConfigureChecks.cmake
	kdm/
	safestartkde.cmake
	startkde.cmake
"

PATCHES=("${FILESDIR}/gentoo-startkde4.patch")

src_prepare() {
	kde4-meta_src_prepare

	# Patch the startkde script to setup the environment for KDE
	# List all the multilib libdirs
	local _libdir _libdirs
	for _libdir in $(get_all_libdirs); do
		_libdirs="${_libdirs}:${KDEDIR}/${_libdir}"
	done
	_libdirs=${_libdirs#:}

	# Sort the LDFLAGS out if necessary
	if use kdeprefix; then
		sed -e "s#@REPLACE_LDFLAGS@#export LDFLAGS=${_libdirs}:\$LDFLAGS#" \
			-i startkde.cmake || die "Sed for LDPATH failed."
	else
		sed -e "s#@REPLACE_LDFLAGS@##" \
			-i startkde.cmake || die "sed for LDPATH failed"
	fi

	# Complete LDPATH
	sed -e "s#@REPLACE_LIBDIR@#$(get_libdir)#" \
		-i startkde.cmake || die "Sed for REPLACE_LIBDIR failed."
	# Now fix the prefix
	sed -e "s#@REPLACE_PREFIX@#${KDEDIR}#" \
		-i startkde.cmake || die "Sed for REPLACE_PREFIX failed."

	# Replace applications menu prefix
	sed -e "s#@REPLACE_MENU_PREFIX@#kde-${SLOT}-#" \
		-i startkde.cmake || die "Sed for REPLACE_MENU_PREFIX failed."
}

src_install() {
	kde4-meta_src_install

	# startup and shutdown scripts
	if use kdeprefix; then
		insinto "${KDEDIR}/env"
	else
		insinto "/etc/kde/startup"
	fi
	doins "${FILESDIR}/agent-startup.sh" || die "doexe agent-startup.sh failed"

	if use kdeprefix; then
		exeinto "${KDEDIR}/shutdown"
	else
		exeinto "/etc/kde/shutdown"
	fi
	doexe "${FILESDIR}/agent-shutdown.sh" || die "doexe agent-shutdown.sh failed"

	# x11 session script
	local DIR="kde-${SLOT}"
	cat <<-EOF > "${T}/${DIR}"
	#!/bin/sh
	exec ${KDEDIR}/bin/startkde
	EOF
	exeinto /etc/X11/Sessions
	doexe "${T}/${DIR}" || die "doexe ${DIR} failed"

	# freedesktop compliant session script
	local KDE_X
	if use kdeprefix; then
		KDE_X="KDE-${SLOT}"
	else
		KDE_X="KDE-4"
	fi
	sed -e "s:\${KDE4_BIN_INSTALL_DIR}:${KDEDIR}/bin:g;s:Name=KDE:Name=KDE ${SLOT}:" \
		"${S}/kdm/kfrontend/sessions/kde.desktop.cmake" > "${T}/${KDE_X}.desktop"
	insinto /usr/share/xsessions
	doins "${T}/${KDE_X}.desktop" || die "doins ${KDE_X}.desktop failed"
}

pkg_postinst () {
	kde4-meta_pkg_postinst

	echo
	elog "To enable gpg-agent and/or ssh-agent in KDE sessions,"
	if use kdeprefix; then
		elog "edit ${KDEDIR}/env/agent-startup.sh and"
		elog "${KDEDIR}/shutdown/agent-shutdown.sh"
	else
		elog "edit /etc/kde/startup/agent-startup.sh and"
		elog "/etc/kde/shutdown/agent-shutdown.sh"
	fi
	echo
}
