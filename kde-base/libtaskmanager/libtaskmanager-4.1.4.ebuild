# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libtaskmanager/libtaskmanager-4.1.3.ebuild,v 1.3 2009/01/04 15:17:09 scarabeus Exp $

EAPI="2"

KMNAME=kdebase-workspace
KMMODULE=libs/taskmanager
inherit kde4-meta

DESCRIPTION="A library that provides basic taskmanager functionality"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug xcomposite"

COMMONDEPEND="
	x11-libs/libXfixes
	x11-libs/libXrender
	xcomposite? ( x11-libs/libXcomposite )"
DEPEND="${COMMONDEPEND}
	>media-sound/phonon-4.1.0
	x11-proto/renderproto
	xcomposite? ( x11-proto/compositeproto )"
RDEPEND="${COMMONDEPEND}"

src_prepare() {
	sed -i \
		-e "s:task.h:task.h taskrmbmenu.h:g" \
		"${S}"/libs/taskmanager/CMakeLists.txt || die "sed failed"
	kde4-meta_src_prepare
}
