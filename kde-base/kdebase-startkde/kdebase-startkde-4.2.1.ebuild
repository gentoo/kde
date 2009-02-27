# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-startkde/kdebase-startkde-4.2.0-r1.ebuild,v 1.1 2009/02/21 19:07:48 dirtyepic Exp $

EAPI="2"

KMNAME="kdebase-workspace"
KMNOMODULE="true"
inherit kde4-meta multilib

DESCRIPTION="Startkde script, which starts a complete KDE session, and associated scripts"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=""
# The KDE apps called from the startkde script.
# These provide the most minimal KDE desktop.
RDEPEND="${DEPEND}
	>=kde-base/kcminit-${PV}:${SLOT}
	>=kde-base/kdebase-desktoptheme-${PV}:${SLOT}
	>=kde-base/kdebase-kioslaves-${PV}:${SLOT}
	>=kde-base/kdedglobalaccel-${PV}:${SLOT}
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
	x11-apps/xprop
"

KMEXTRACTONLY="
	startkde.cmake
	ConfigureChecks.cmake
	kdm/
	safestartkde.cmake
"
KMCOMPILEONLY="kdm/kfrontend/sessions/"

PATCHES=("${FILESDIR}/gentoo-startkde4.patch")

src_configure() {
	# Patch the startkde script to setup the environment for KDE SVN
	# List all the multilib libdirs
	local _libdir _libdirs
	for _libdir in $(get_all_libdirs); do
		_libdirs="${_libdirs}:${PREFIX}/${_libdir}"
	done
	_libdirs=${_libdirs#:}

	# Sort the LDFLAGS out if necessary
	if use kdeprefix; then
		sed -e "s#@REPLACE_LDFLAGS@#export LDFLAGS=${_libdirs}:\$LDFLAGS#" \
			-i "${S}/startkde.cmake" || die "Sed for LDPATH failed."
	else
		sed -e "s#@REPLACE_LDFLAGS@##" -i "${S}/startkde.cmake" || \
			die "sed for LDPATH failed"
	fi

	# Complete LDPATH
	sed -e "s#@REPLACE_LIBDIR@#$(get_libdir)#" \
		-i "${S}/startkde.cmake" || die "Sed for REPLACE_LIBDIR failed."
	# Now fix the prefix
	sed -e "s#@REPLACE_PREFIX@#${KDEDIR}#" \
		-i "${S}/startkde.cmake" || die "Sed for REPLACE_PREFIX failed."

	kde4-meta_src_configure
}

src_install() {
	local DIR

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

	# freedesktop environment variables
	cat <<-EOF > "${T}/xdg.sh"
	export XDG_DATA_DIRS="${KDEDIR}/share:/usr/share"
	export XDG_CONFIG_DIRS="${KDEDIR}/etc/xdg:/etc/xdg"
	EOF
	if use kdeprefix; then
		insinto "${KDEDIR}/env"
	else
		insinto "/etc/kde/startup"
	fi
	doins "${T}/xdg.sh" || die "doins xdg.sh failed"

	# Set DIR to S{SLOT} for the kde-4 and kde-svn slot or kde-${SLOT} for all other slots
	case "${SLOT}" in
		kde-4 | kde-svn) DIR="${SLOT}" ;;
		*) DIR="kde-${SLOT}"
	esac

	# x11 session script
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
