# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktimetracker/ktimetracker-4.1.3.ebuild,v 1.2 2008/11/16 08:08:10 vapier Exp $

EAPI="2"

KMNAME=kdepim
KMMODULE=ktimetracker
inherit kde4-meta

DESCRIPTION="KTimeTracker tracks time spent on various tasks."
IUSE="debug"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

DEPEND="kde-base/kontact:${SLOT}
	kde-base/kdepim-kresources:${SLOT}
	kde-base/libkdepim:${SLOT}"

KMEXTRACTONLY="
	kresources/remote
	libkdepim
"
KMLOADLIBS="libkdepim kontactinterfaces"
