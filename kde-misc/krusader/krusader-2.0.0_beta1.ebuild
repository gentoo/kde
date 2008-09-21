# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

NEED_KDE="4.1"
inherit kde4-base

MY_P="${P/_/-}"

DESCRIPTION="An advanced twin-panel (commander-style) file-manager for KDE with many extras."
HOMEPAGE="http://krusader.sourceforge.net/"
SRC_URI="mirror://sourceforge/krusader/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="pic"

LNGS="bg bs ca cs da de el es fr hu it ja lt nl pl pt pt_BR ru sk sl sr sv tr uk zh_CN"
for LNG in ${LNGS}; do
	IUSE="${IUSE} linguas_${LNG}"
done

DEPEND="!kdeprefix? ( !kde-misc/krusader:0 )
	sys-devel/gettext"

S="${WORKDIR}/${MY_P}"
PREFIX="${KDEDIR}"

src_unpack() {
	local LNG
	unpack ${A}
	cd "${S}"/po
	# take care of linguas
	for LNG in ${LINGUAS}; do
		use linguas_${LNG} || rm -f "${LNG}".po
	done
}

src_compile() {
	local mycmakeargs
	# for paranoid users
	use pic && mycmakeargs="${mycmakeargs} -DKDE4_ENABLE_FPIE"

	kde4-base_src_compile
}
