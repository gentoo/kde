# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksplash/ksplash-4.2.1.ebuild,v 1.2 2009/03/08 14:00:57 scarabeus Exp $

EAPI="2"

KMNAME="kdebase-workspace"
inherit kde4-meta

DESCRIPTION="KDE splashscreen framework (the splashscreen of KDE itself, not of individual apps)"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="3dnow altivec debug mmx sse sse2 xinerama"

COMMONDEPEND="
	media-libs/libpng
	xinerama? ( x11-libs/libXinerama )
"
DEPEND="${COMMONDEPEND}
	xinerama? ( x11-proto/xineramaproto )
"
RDEPEND="${COMMONDEPEND}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_has 3dnow X86_3DNOW)
		$(cmake-utils_use_has altivec PPC_ALTIVEC)
		$(cmake-utils_use_has mmx X86_MMX)
		$(cmake-utils_use_has sse X86_SSE)
		$(cmake-utils_use_has sse2 X86_SSE2)
		$(cmake-utils_use_with xinerama X11_Xinerama)"

	kde4-meta_src_configure
}
