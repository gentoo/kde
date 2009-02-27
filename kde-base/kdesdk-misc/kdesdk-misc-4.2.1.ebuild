# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-misc/kdesdk-misc-4.2.0.ebuild,v 1.2 2009/02/01 07:03:44 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdesdk"
KMNOMODULE="true"
inherit kde4-meta

DESCRIPTION="kdesdk-misc - Various files and utilities"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="!kde-base/poxml"

KMEXTRA="
	poxml/
	kprofilemethod/"
