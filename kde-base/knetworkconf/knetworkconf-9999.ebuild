# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdeadmin"
inherit kde4-meta

DESCRIPTION="KDE control Center Module to confiure Network settings"
KEYWORDS=""
IUSE="debug +handbook"

src_unpack() {
	use handbook && KMEXTRA="doc/kcontrol/${PN}"

	kde4-meta_src_unpack
}
