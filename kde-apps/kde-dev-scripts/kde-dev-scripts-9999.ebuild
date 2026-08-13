# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_AUTODEPS="minimal"
ECM_HANDBOOK="optional"
KFMIN=6.27.0
inherit ecm gear.kde.org

DESCRIPTION="KDE Development Scripts"

LICENSE="GPL-2" # TODO: CHECK
SLOT="6"
KEYWORDS=""
IUSE=""

RDEPEND="
	app-arch/advancecomp
	dev-perl/XML-DOM
	media-gfx/optipng
"

src_prepare() {
	ecm_src_prepare
	sed -e '/colorsvn/s/^/# bug 275069 - /' -i CMakeLists.txt || die
}
