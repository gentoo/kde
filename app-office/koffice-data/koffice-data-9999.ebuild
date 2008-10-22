# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
SLOT="kde-svn"
KMNAME=koffice
KMNOMODULE=true
inherit kde4svn-meta

DESCRIPTION="Shared KOffice data files."
KEYWORDS=""
IUSE=""

KMEXTRA="servicetypes/
	pics/
	templates/"
