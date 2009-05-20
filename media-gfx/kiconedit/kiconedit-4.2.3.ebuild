# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_LINGUAS="af ar be bg br ca cs cy da de el en_GB eo es et eu fa fi fr ga gl
	he hi hr hu is it ja km ko lt lv mk ms nb nds ne nl nn oc pa pl pt pt_BR
	ro ru se sk sl sv ta tg th tr uk vi wa xh zh_CN zh_HK zh_TW"

KMNAME="extragear/graphics"
inherit kde4-base

DESCRIPTION="KDE Icon Editor"
HOMEPAGE="http://www.kde.org/"
SRC_URI="mirror://kde/stable/${PV}/src/extragear/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug doc"

src_prepare() {
	kde4-base_src_prepare

	if ! use doc; then
		sed -i \
			-e "/^add_subdirectory[[:space:]]*([[:space:]]*doc[[:space:]]*)/s/^/# DISABLED /" \
			-e "/^add_subdirectory[[:space:]]*([[:space:]]*doc-translations[[:space:]]*)/s/^/# DISABLED /" \
			CMakeLists.txt || die "sed doc failed"
	else
		sed -i \
			-e "s:\${HTML_INSTALL_DIR}/en:\${HTML_INSTALL_DIR}/en SUBDIR ${PN}:g" \
			doc/CMakeLists.txt || die "fix doc placement failed"
	fi
}
