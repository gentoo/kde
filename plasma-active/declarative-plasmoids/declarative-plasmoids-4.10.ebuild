# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="Declarative plasmoids for the plasma desktop and mobile"
HOMEPAGE="https://projects.kde.org/projects/playground/base/declarative-plasmoids"
SRC_URI="mirror://kde/stable/active/3.0/src/${P}.tar.xz"

LICENSE="LGPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=""

RDEPEND="${DEPEND}"
