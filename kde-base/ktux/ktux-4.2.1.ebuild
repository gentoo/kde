# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktux/ktux-4.2.0.ebuild,v 1.2 2009/02/01 08:10:53 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdetoys"
inherit kde4-meta

DESCRIPTION="KDE: screensaver featuring the Space-Faring Tux"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND=">=kde-base/kscreensaver-${PV}:${SLOT}"

src_prepare() {
	sed -i -e's/${KDE4WORKSPACE_KSCREENSAVER_LIBRARY}/kscreensaver/' \
	"${PN}"/CMakeLists.txt || die "Failed to patch CMakeLists.txt"

	kde4-meta_src_prepare
}
