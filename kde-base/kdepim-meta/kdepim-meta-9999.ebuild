# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit kde4overlay-functions

DESCRIPTION="kdepim - merge this to pull in all kdepim-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="kde-svn"
KEYWORDS=""
IUSE=""

RDEPEND="
	app-office/akonadi-server
	>=kde-base/akregator-${PV}:${SLOT}
	>=kde-base/kaddressbook-${PV}:${SLOT}
	>=kde-base/kdemaildir-${PV}:${SLOT}
	>=kde-base/kleopatra-${PV}:${SLOT}
	>=kde-base/kmail-${PV}:${SLOT}
	>=kde-base/kmailcvt-${PV}:${SLOT}
	>=kde-base/knode-${PV}:${SLOT}
	>=kde-base/kode-${PV}:${SLOT}
	>=kde-base/kontact-${PV}:${SLOT}
	>=kde-base/korganizer-${PV}:${SLOT}
	>=kde-base/libkdepim-${PV}:${SLOT}
	>=kde-base/libkholidays-${PV}:${SLOT}
	>=kde-base/libkleo-${PV}:${SLOT}
	>=kde-base/libkpgp-${PV}:${SLOT}
	>=kde-base/libksieve-${PV}:${SLOT}
	>=kde-base/mimelib-${PV}:${SLOT}
	>=kde-base/kalarm-${PV}:${SLOT}
	>=kde-base/kjots-${PV}:${SLOT}
	>=kde-base/knotes-${PV}:${SLOT}
	>=kde-base/kdepim-kresources-${PV}:${SLOT}
	>=kde-base/ktimetracker-${PV}:${SLOT}
	>=kde-base/kdepim-strigi-analyzer-${PV}:${SLOT}
	>=kde-base/kdepim-wizards-${PV}:${SLOT}
	>=kde-base/kontact-specialdates-${PV}:${SLOT}
	"
# could be in kdepim-meta but arent due to:
#        >=kde-base/korn-${PV}:${SLOT} fails to build
#	>=kde-base/certmanager-${PV}:${SLOT} probably obsolete by kleopatra
#	>=kde-base/kabc2mutt-${PV}:${SLOT} dont know
#	>=kde-base/kabcclient-${PV}:${SLOT} not modified for a long time
#	>=kde-base/kdepim-kioslaves-${PV}:${SLOT} seems kicked from svn
#	>=kde-base/kfeed-${PV}:${SLOT} is in playground
#	>=kde-base/kitchensync-${PV}:${SLOT} not modified for a long time
#	>=kde-base/kmobiletools-${PV}:${SLOT} not modified for a long time
#	>=kde-base/kpilot-${PV}:${SLOT} not modified for a long time
#	>=kde-base/mailtransport-${PV}:${SLOT} kicked from svn
#	>=kde-base/networkstatus-${PV}:${SLOT} kicked from svn
#	>=kde-base/ktnef-${PV}:${SLOT}	kicked from svn
#   >=kde-base/konsolekalendar-${PV}:${SLOT} seems unmaintained
