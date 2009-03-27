# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/plasma-workspace/plasma-workspace-4.2.1-r1.ebuild,v 1.1 2009/03/15 14:43:13 scarabeus Exp $

EAPI="2"

KMNAME="kdebase-workspace"
KMMODULE="plasma"
inherit python kde4-meta

DESCRIPTION="Plasma: KDE desktop framework"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug google-gadgets python rss xcomposite xinerama"

COMMONDEPEND="
	>=kde-base/kephal-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/ksysguard-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libkworkspace-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libplasmaclock-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libtaskmanager-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/soliduiserver-${PV}:${SLOT}[kdeprefix=]
	x11-libs/libXau
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXtst
	google-gadgets? ( >=x11-misc/google-gadgets-0.10.5[qt4] )
	python? (
		>=dev-python/PyQt4-4.4.0
		>=dev-python/sip-4.7.1
		>=kde-base/pykde4-${PV}:${SLOT}[kdeprefix=]
	)
	rss? ( >=kde-base/kdepimlibs-${PV}:${SLOT}[kdeprefix=] )
	xcomposite? ( x11-libs/libXcomposite )
	xinerama? ( x11-libs/libXinerama )
"
DEPEND="${COMMONDEPEND}
	xcomposite? ( x11-proto/compositeproto )
	xinerama? ( x11-proto/xineramaproto )
"
RDEPEND="${COMMONDEPEND}
	!kdeprefix? ( !kde-base/plasma[-kdeprefix] )
	>=kde-base/kioclient-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kde-menu-icons-${PV}:${SLOT}[kdeprefix=]
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

PATCHES=(
	"${FILESDIR}/4.2.1-panelview-crash-fix.patch"
	"${FILESDIR}/4.2-fix-quicklaunch.patch"
)

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
	rm -f "${D}/usr/$(get_libdir)/python${PYVER}"/site-packages/PyKDE4/*.py[co]
	rm -f "${D}${PREFIX}"/share/apps/plasma_scriptengine_python/*.py[co]
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	python_mod_optimize \
		"/usr/$(get_libdir)/python${PYVER}"/site-packages/PyKDE4 \
		"${PREFIX}"/share/apps/plasma_scriptengine_python
}

pkg_postrm() {
	kde4-meta_pkg_postrm

	python_mod_cleanup
}
