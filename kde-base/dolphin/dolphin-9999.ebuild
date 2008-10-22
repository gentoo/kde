# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdebase
KMMODULE=apps/${PN}
inherit kde4svn-meta

DESCRIPTION="A KDE filemanager focusing on usability"
KEYWORDS=""
IUSE="debug htmlhandbook +semantic-desktop"

DEPEND="kde-base/kdelibs:${SLOT}
	>=kde-base/libkonq-${PV}:${SLOT}
	semantic-desktop? ( >=kde-base/nepomuk-${PV}:${SLOT} )"
RDEPEND="${DEPEND}"

KMEXTRA="apps/doc/${PN}"
KMLOADLIBS="libkonq"

#PATCHES="${FILESDIR}/${P}-make-semantic-desktop-optional.patch" is not needed anymore as said in genkdesvn

pkg_setup() {
	if use semantic-desktop && ! built_with_use kde-base/kdelibs semantic-desktop; then
		eerror "In order to build "
		eerror "you need kde-base/kdelibs built with semantic-desktop USE flag "
		die "no semantic-desktop support in kdelibs"
	fi
}

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)"
	kde4overlay-meta_src_compile
}
