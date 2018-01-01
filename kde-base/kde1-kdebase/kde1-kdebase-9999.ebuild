# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="KDE 1 base applications, adapted to compile on modern systems (circa. 2016)"
HOMEPAGE="https://quickgit.kde.org/?p=kde1-kdebase.git"
EGIT_REPO_URI="git://anongit.kde.org/${PN}.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-qt/qt1
	kde-base/kde1-kdelibs
	x11-libs/libX11
"
RDEPEND="${DEPEND}"

src_compile() {
	pushd "${BUILD_DIR}"
	# don't ask
	nonfatal emake
	emake
}
