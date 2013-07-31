# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="KCM displaying distribution and system information"
HOMEPAGE="http://quickgit.kde.org/?p=about-distro.git"
SRC_URI="http://www.gentoo.org/images/glogo-small.png"
EGIT_REPO_URI="git://anongit.kde.org/${PN}"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS=""
IUSE="debug"

src_install() {
	kde4-base_src_install

	insinto /usr/share/config
	doins "${FILESDIR}"/kcm-about-distrorc

	insinto /usr/share/${PN}
	doins "${DISTDIR}"/glogo-small.png
}
