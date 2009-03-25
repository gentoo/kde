# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/automoc/automoc-0.9.84.ebuild,v 1.5 2009/03/05 16:04:56 mr_bones_ Exp $

EAPI="2"

inherit cmake-utils flag-o-matic

DESCRIPTION="KDE Meta Object Compiler"
HOMEPAGE="http://www.kde.org/"
SRC_URI="mirror://kde/unstable/${PN}4/${PV}/${PN}4-${PV}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="
	x11-libs/qt-core:4
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}4-${PV}"

src_prepare() {
	if [[ ${ELIBC} == "uclibc" ]]; then
		append-flags -pthread
	fi
}
