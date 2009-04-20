# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="Akonadi based Addressbook for KDE"
HOMEPAGE="http://kde.org/"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="debug"

DEPEND="kde-base/akonadi:${SLOT}"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="akonadi/kabc"

src_prepare()
{
kde4-meta_src_prepare
sed -i -e "'s:\ \ #\ macro:macro:g' ${WORKDIR}/${P}/CMakeLists.txt"
}
