# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="4.1"
inherit kde4-base

DESCRIPTION="A quake-style terminal emulator based on KDE konsole technology"
HOMEPAGE="http://yakuake.kde.org/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE=""

DEPEND=">=kde-base/konsole-4.1.0
	sys-devel/gettext
	!kdeprefix? ( !kde-misc/yakuake:0 )"
RDEPEND="${DEPEND}"

#linguas
LANGS="ca cs da de el en_GB fr ga gl ja ko nds nl pt pt_BR ro ru sv tr uk"
for LANG in ${LANGS}; do
	IUSE="${IUSE} linguas_${LANG}"
done

# take care of wrong prefixing
PREFIX="${KDEDIR}"

src_unpack() {
	local LANG
	unpack ${A}
	cd "${S}"
	# take care of linguas
	comment_all_add_subdirectory po/ || die "sed to remove all linguas failed."
	for LANG in ${LINGUAS}; do
		sed -i \
			-e "/add_subdirectory(\s*${LANG}\s*)\s*$/ s/^#DONOTCOMPILE //" \
			po/CMakeLists.txt || die "Sed to uncomment ${LANG} failed."
	done
}
