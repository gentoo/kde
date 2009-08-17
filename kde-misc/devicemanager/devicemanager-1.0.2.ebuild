# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="Advanced Device Notifier Plasmoid"
HOMEPAGE="http://kde-look.org/content/show.php/Device+Manager?content=106051"
SRC_URI="http://kde-look.org/CONTENT/content-files/106051-${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

RDEPEND="
	>=kde-base/plasma-workspace-${KDE_MINIMAL}
"

S="${WORKDIR}/${PN}"

src_install() {
	kde4-base_src_install

	# colliding file with plasma-workspace
	rm -rf "${D}/${PREFIX}"/share/apps/solid/actions/test-predicate-openinwindow.desktop
}
