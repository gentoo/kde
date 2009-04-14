# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"

inherit kde4-meta

DESCRIPTION="KDE app that tracks time spent on various tasks."
KEYWORDS=""
IUSE="debug doc"

DEPEND="
	>=kde-base/kdepim-kresources-${PV}[kdeprefix=]
	>=kde-base/libkdepim-${PV}[kdeprefix=]"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="kresources/"

KMLOADLIBS="libkdepim kontactinterfaces"
