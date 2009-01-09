# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-misc/kdesdk-misc-4.1.3.ebuild,v 1.2 2008/11/16 07:26:01 vapier Exp $

EAPI="2"

KMNAME=kdesdk
KMNOMODULE="true"
inherit kde4-meta

DESCRIPTION="kdesdk-misc - Various files and utilities"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="!kde-base/poxml"

# FIXME:
# currently doesn't do anything:
#	kdepalettes
# currently disabled on CMakeLists.txt
#	scheck
KMEXTRA="
	poxml/
	kprofilemethod/"
