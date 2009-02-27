# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepasswd/kdepasswd-4.2.0.ebuild,v 1.2 2009/02/01 06:59:17 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdebase"
KMMODULE="apps/${PN}"

inherit kde4-meta

DESCRIPTION="KDE GUI for passwd"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND=">=kde-base/libkonq-${PV}:${SLOT}"
RDEPEND="${DEPEND}
	>=kde-base/kdesu-${PV}:${SLOT}"

KMLOADLIBS="libkonq"
