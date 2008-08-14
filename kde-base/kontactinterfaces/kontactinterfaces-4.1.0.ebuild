# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdepim
inherit kde4-meta

DESCRIPTION="Interfaces library for the KDE personal information manager"
KEYWORDS="~amd64"
IUSE="debug htmlhandbook"

KMSAVELIBS="true"
KMEXTRACTONLY="libkdepim"
