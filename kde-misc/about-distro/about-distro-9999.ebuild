# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="KCM displaying distribution and system information"
HOMEPAGE="https://projects.kde.org/projects/playground/base/about-distro"
SRC_URI="http://www.gentoo.org/images/glogo-small.png"

if [[ ${KDE_BUILD_TYPE} != live ]]; then
	SRC_URI+=" mirror://kde/stable/${PN}/${PV}/src/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
else
	EGIT_REPO_URI="git://anongit.kde.org/${PN}"
	KEYWORDS=""
fi

LICENSE="GPL-3"

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep solid)
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"
RDEPEND="${DEPEND}
	!kde-misc/about-distro:4
"

src_install() {
	kde5_src_install

	insinto /etc/xdg
	doins "${FILESDIR}"/kcm-about-distrorc

	insinto /usr/share/${PN}
	doins "${DISTDIR}"/glogo-small.png
}
