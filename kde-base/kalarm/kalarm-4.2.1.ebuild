# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalarm/kalarm-4.2.0.ebuild,v 1.2 2009/02/01 06:28:07 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="Personal alarm message, command and email scheduler for KDE"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""
DEPEND=">=kde-base/libkdepim-${PV}:${SLOT}
	>=kde-base/libkholidays-${PV}:${SLOT}"

KMEXTRACTONLY="kmail
	libkholidays
	libkdepim"
