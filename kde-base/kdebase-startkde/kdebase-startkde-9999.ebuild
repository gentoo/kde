# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdebase-workspace
KMNOMODULE=true
inherit multilib kde4svn-meta

DESCRIPTION="Startkde script, which starts a complete KDE session, and associated scripts"
KEYWORDS=""
IUSE=""

DEPEND=""
# The KDE apps called from the startkde script.
# These provide the most minimal KDE desktop.
RDEPEND="${DEPEND}
	>=kde-base/kcminit-${PV}:${SLOT}
	>=kde-base/kdebase-data-${PV}:${SLOT}
	>=kde-base/kdebase-kioslaves-${PV}:${SLOT}
	>=kde-base/kde-wallpapers-${PV}:${SLOT}
	>=kde-base/knotify-${PV}:${SLOT}
	>=kde-base/kreadconfig-${PV}:${SLOT}
	>=kde-base/krunner-${PV}:${SLOT}
	>=kde-base/ksmserver-${PV}:${SLOT}
	>=kde-base/ksplash-${PV}:${SLOT}
	>=kde-base/kstartupconfig-${PV}:${SLOT}
	>=kde-base/kstyles-${PV}:${SLOT}
	>=kde-base/kwin-${PV}:${SLOT}
	>=kde-base/plasma-apps-${PV}:${SLOT}
	>=kde-base/plasma-workspace-${PV}:${SLOT}
	>=kde-base/systemsettings-${PV}:${SLOT}
	x11-apps/xmessage
	x11-apps/xsetroot
	x11-apps/xset
	x11-apps/xrandr
	x11-apps/mkfontdir
	x11-apps/xprop"

KMEXTRACTONLY="startkde.cmake
	ConfigureChecks.cmake
	kdm/"
KMCOMPILEONLY="kdm/kfrontend/sessions/"

# PATCHES="${FILESDIR}/gentoo-startkde.patch"

src_compile() {
	epatch "${FILESDIR}"/gentoo-startkde.patch
	# Patch the startkde script to setup the environment for KDE 4.0
	# Add our KDEDIR
	sed -e "s#@REPLACE_PREFIX@#${PREFIX}#" \
		-i "${S}/startkde.cmake" || die "Sed for PREFIX failed."

	# List all the multilib libdirs
	local _libdir _libdirs
	for _libdir in $(get_all_libdirs); do
		_libdirs="${_libdirs}:${PREFIX}/${_libdir}"
	done
	_libdirs=${_libdirs#:}

	# Complete LDPATH
	sed -e "s#@REPLACE_LIBS@#${_libdirs}#" \
		-i "${S}/startkde.cmake" || die "Sed for LDPATH failed."

	kde4overlay-meta_src_compile
}

src_install() {
	kde4overlay-meta_src_install

	# startup and shutdown scripts
	insinto "${KDEDIR}/env"
	doins "${FILESDIR}/agent-startup.sh" || die "doexe agent-startup.sh failed"

	exeinto "${KDEDIR}/shutdown"
	doexe "${FILESDIR}/agent-shutdown.sh" || die "doexe agent-shutdown.sh failed"

	# freedesktop environment variables
	cat <<-EOF > "${T}/xdg.sh"
	export XDG_DATA_DIRS="${KDEDIR}/share:/usr/share"
	export XDG_CONFIG_DIRS="${KDEDIR}/etc/xdg"
	EOF
	insinto "${KDEDIR}/env"
	doins "${T}/xdg.sh" || die "doins xdg.sh failed"

	# x11 session script
	cat <<-EOF > "${T}/${SLOT}"
	#!/bin/sh
	exec ${KDEDIR}/bin/startkde
	EOF
	exeinto /etc/X11/Sessions
	doexe "${T}/${SLOT}" || die "doexe ${SLOT} failed"

	# freedesktop compliant session script
	sed -e "s:\${KDE4_BIN_INSTALL_DIR}:${KDEDIR}/bin:g;s:Name=KDE:Name=${SLOT}:" \
		"${S}/kdm/kfrontend/sessions/kde.desktop.cmake" > "${T}/${SLOT}.desktop"
	insinto /usr/share/xsessions
	doins "${T}/${SLOT}.desktop" || die "doins ${SLOT}.desktop failed"
}

pkg_postinst () {
	kde4overlay-meta_pkg_postinst

	echo
	elog "To enable gpg-agent and/or ssh-agent in KDE sessions,"
	elog "edit ${KDEDIR}/env/agent-startup.sh and"
	elog "${KDEDIR}/shutdown/agent-shutdown.sh"
	echo
}
