# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kscreensaver/kscreensaver-4.2.1.ebuild,v 1.4 2009/03/11 20:53:54 scarabeus Exp $

EAPI="2"

KMNAME="kdebase-workspace"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="KDE screensaver framework"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug pam"

RDEPEND="
	dev-libs/glib
	>=kde-base/kcheckpass-${PV}:${SLOT}[kdeprefix=]
	>=x11-libs/libxklavier-3.2
	>=x11-libs/libXrandr-1.2.1
	x11-libs/libXtst
	opengl? ( virtual/opengl )
	pam? (
		>=kde-base/kdebase-pam-7
		virtual/pam
	)
"
DEPEND="${RDEPEND}
	x11-proto/randrproto
"

PATCHES=( "${FILESDIR}/kdebase-4.0.2-pam-optional.patch" )

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with pam PAM)"

	kde4-meta_src_configure
}
