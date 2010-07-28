# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=2

inherit kde4-base git

DESCRIPTION="A Qt wrapper for bluez used in the KDE bluetooth stack"
HOMEPAGE="http://gitorious.org/libbluedevil"
EGIT_REPO_URI="git://gitorious.org/libbluedevil/libbluedevil.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="alsa"

DEPEND="net-wireless/bluez"
RDEPEND="${DEPEND}
	alsa? ( net-wireless/bluez[alsa] )
"
