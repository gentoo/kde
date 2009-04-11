# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Based in parts upon a work of individual contributors of the genkdesvn project

EAPI="2"

KMNAME="kdesdk"
KMNOMODULE="true"
inherit kde4-meta

DESCRIPTION="kdesdk-misc - Various files and utilities"
KEYWORDS="~alpha ~amd64 ~ia64 ~x86"
IUSE="debug"

KMEXTRA="
	kmtrace/
	kpartloader/
	kprofilemethod/
	poxml/
"
