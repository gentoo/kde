# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/plasma-workspace/plasma-workspace-4.2.2.ebuild,v 1.2 2009/04/17 06:42:19 alexxy Exp $

EAPI="2"

KMNAME="kdebase-workspace"
KMMODULE="plasma"
inherit python kde4-meta

DESCRIPTION="Plasma: KDE desktop framework"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug doc google-gadgets python rss xcomposite xinerama"

COMMONDEPEND="
	>=kde-base/kephal-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/ksysguard-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libkworkspace-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libplasmaclock-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libtaskmanager-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/solid-${PV}:${SLOT}[kdeprefix=]
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libXrender
	google-gadgets? ( >=x11-misc/google-gadgets-0.10.5[qt4] )
	python? (
		>=dev-python/PyQt4-4.4.0
		>=dev-python/sip-4.7.1
		>=kde-base/pykde4-${PV}:${SLOT}[kdeprefix=]
	)
	rss? ( >=kde-base/kdepimlibs-${PV}:${SLOT}[kdeprefix=] )
	xinerama? ( x11-libs/libXinerama )
"
DEPEND="${COMMONDEPEND}
	x11-proto/compositeproto
	x11-proto/damageproto
	x11-proto/fixesproto
	x11-proto/renderproto
	xinerama? ( x11-proto/xineramaproto )
"
RDEPEND="${COMMONDEPEND}
	>=kde-base/kioclient-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kde-menu-icons-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/soliduiserver-${PV}:${SLOT}[kdeprefix=]
"

KMEXTRA="
	libs/nepomukquery/
	libs/nepomukqueryclient/
"
KMEXTRACTONLY="
	krunner/dbus/org.freedesktop.ScreenSaver.xml
	krunner/dbus/org.kde.krunner.App.xml
	ksmserver/org.kde.KSMServerInterface.xml
	libs/kworkspace/
	libs/taskmanager/
	ksysguard/
"

KMLOADLIBS="libkworkspace libplasmaclock libtaskmanager"

src_prepare() {
	kde4-meta_src_prepare

	if ! use xcomposite; then
		# Add David Nolder (zwabel) experimental fake transparency patch
		echo
		ewarn "Enabling experimental fake transparency support."
		ewarn "There are known issues with certain versions of Qt."
		ewarn "Do not report any bugs."
		echo
		epatch "${FILESDIR}/${PN}-fake-panel-transparency.patch"
	fi
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with google-gadgets Googlegadgets)
		$(cmake-utils_use_with python SIP)
		$(cmake-utils_use_with python PyQt4)
		$(cmake-utils_use_with python PyKDE4)
		$(cmake-utils_use_with rss KdepimLibs)
		-DWITH_Xmms=OFF"

	kde4-meta_src_configure
}

src_install() {
	kde4-meta_src_install

	python_version
	rm -f \
		"${D}/usr/$(get_libdir)/python${PYVER}"/site-packages/PyKDE4/*.py[co] \
		"${D}${KDEDIR}"/share/apps/plasma_scriptengine_python/*.py[co]
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	if use python; then
		python_mod_optimize \
			"/usr/$(get_libdir)/python${PYVER}"/site-packages/PyKDE4 \
			"${KDEDIR}"/share/apps/plasma_scriptengine_python
	fi
}

pkg_postrm() {
	kde4-meta_pkg_postrm

	if [[ -d "${KDEDIR}"/share/apps/plasma_scriptengine_python ]]; then
		python_mod_cleanup \
			"/usr/$(get_libdir)/python${PYVER}"/site-packages/PyKDE4 \
			"${KDEDIR}"/share/apps/plasma_scriptengine_python
	fi
}
