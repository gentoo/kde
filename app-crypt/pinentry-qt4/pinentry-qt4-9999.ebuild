# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="playground/pim"
KMMODULE="pinentry-qt4"
inherit kde4-base

DESCRIPTION="Collection of simple PIN or passphrase entry dialogs which utilize the Assuan protocol"
HOMEPAGE="http://kde.org/"
LICENSE="GPL-2 LGPL-2"

KEYWORDS=""
IUSE=""
SLOT="live"

DEPEND="app-crypt/pinentry"
