# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksplash/ksplash-4.2.0.ebuild,v 1.2 2009/02/01 07:58:11 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdebase-workspace"
inherit kde4-meta

DESCRIPTION="KDE splashscreen framework (the splashscreen of KDE itself, not of individual apps)"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="3dnow altivec debug mmx sse sse2 xinerama"

RDEPEND="media-libs/libpng
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${RDEPEND}
	xinerama? ( x11-proto/xineramaproto )"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_has 3dnow X86_3DNOW)
		$(cmake-utils_has altivec PPC_ALTIVEC)
		$(cmake-utils_has mmx X86_MMX)
		$(cmake-utils_has sse X86_SSE)
		$(cmake-utils_has sse2 X86_SSE2)
		$(cmake-utils_use_with xinerama X11_Xinerama)"

	kde4-meta_src_configure
}
