# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit kde4-functions

DESCRIPTION="KDE WebDev - merge this to pull in all kdewebdev-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.3"
KEYWORDS=""
# FIXME:
# Add this back when adding kmtrace
# elibc_glibc
IUSE="kdeprefix"

RDEPEND="
	>=kde-base/kfilereplace-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kimagemapeditor-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/klinkstatus-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kommander-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kxsldbg-${PV}:${SLOT}[kdeprefix=]
	$(block_other_slots)
"
