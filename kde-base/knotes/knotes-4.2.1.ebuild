# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/knotes/knotes-4.2.0.ebuild,v 1.2 2009/02/01 07:37:53 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KDE Notes"
IUSE="debug"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

DEPEND="kde-base/libkdepim:${SLOT}"

KMEXTRACTONLY="libkdepim"
KMLOADLIBS="libkdepim"
