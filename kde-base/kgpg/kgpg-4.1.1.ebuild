# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2_pre3"

KMNAME=kdeutils
inherit kde4-meta

DESCRIPTION="KDE gpg keyring manager"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

RDEPEND="app-crypt/gnupg"
