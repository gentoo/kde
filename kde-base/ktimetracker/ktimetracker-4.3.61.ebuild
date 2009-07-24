# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"

inherit kde4-meta

DESCRIPTION="KDE app that tracks time spent on various tasks."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug +handbook"

DEPEND="
	>=kde-base/kdepim-kresources-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libkdepim-${PV}:${SLOT}[kdeprefix=]"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="kresources/"

KMLOADLIBS="libkdepim"


src_unpack() {
        if use kontact; then
                KMLOADLIBS="${KMLOADLIBS} kontactinterfaces"
                KMEXTRA="${KMEXTRA} kontact/plugins/ktimetracker"
        fi

        kde4-meta_src_unpack
}

