# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-workspace"
KMNOMODULE="true"
inherit kde4-meta multilib prefix

DESCRIPTION="Startkde script, which starts a complete KDE session, and associated scripts"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

# The KDE apps called from the startkde script.
# These provide the most minimal KDE desktop.
RDEPEND="
	$(add_kdebase_dep kcminit)
	$(add_kdebase_dep kdebase-runtime-meta)
	$(add_kdebase_dep kdebase-wallpapers)
	$(add_kdebase_dep kfmclient)
	$(add_kdebase_dep knotify)
	$(add_kdebase_dep kreadconfig)
	$(add_kdebase_dep krunner)
	$(add_kdebase_dep ksmserver)
	$(add_kdebase_dep ksplash)
	$(add_kdebase_dep kstartupconfig)
	$(add_kdebase_dep kwin)
	$(add_kdebase_dep phonon-kde)
	$(add_kdebase_dep plasma-apps)
	$(add_kdebase_dep plasma-workspace)
	$(add_kdebase_dep systemsettings)
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

PATCHES=("${FILESDIR}/gentoo-startkde4-2.patch")

src_prepare() {
	kde4-meta_src_prepare

	# Patch the startkde script to setup the environment for KDE
	# List all the multilib libdirs
	local _libdir _libdirs=
	for _libdir in $(get_all_libdirs); do
		_libdirs+=":${EKDEDIR}/${_libdir}"
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
	# ... and fix ${EPREFIX}
	eprefixify startkde.cmake
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

	if use kdeprefix; then
		KDE_X="KDE-${SLOT}"
	else
		KDE_X="KDE-4"
	fi

	# x11 session script
	cat <<-EOF > "${T}/${KDE_X}"
	#!/bin/sh
	exec "${EKDEDIR}/bin/startkde"
	EOF
	exeinto /etc/X11/Sessions
	doexe "${T}/${KDE_X}" || die "doexe ${KDE_X} failed"

	# freedesktop compliant session script
	sed -e "s:\${KDE4_BIN_INSTALL_DIR}:${EKDEDIR}/bin:g;s:Name=KDE:Name=KDE ${SLOT}:" \
		"${S}/kdm/kfrontend/sessions/kde.desktop.cmake" > "${T}/${KDE_X}.desktop"
	insinto /usr/share/xsessions
	doins "${T}/${KDE_X}.desktop" || die "doins ${KDE_X}.desktop failed"
}

pkg_postinst () {
	kde4-meta_pkg_postinst

	echo
	elog "To enable gpg-agent and/or ssh-agent in KDE sessions,"
	if use kdeprefix; then
		elog "edit ${EKDEDIR}/env/agent-startup.sh and"
		elog "${EKDEDIR}/shutdown/agent-shutdown.sh"
	else
		elog "edit ${EPREFIX}/etc/kde/startup/agent-startup.sh and"
		elog "${EPREFIX}/etc/kde/shutdown/agent-shutdown.sh"
	fi
	echo
	elog "The name of the session script has changed."
	elog "If you currently have XSESSION=\"kde-${SLOT}\" in your"
	elog "configuration files, you will need to change it to"
	elog "XSESSION=\"${KDE_X}\""
}
