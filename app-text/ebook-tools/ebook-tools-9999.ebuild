# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KDE_ORG_CATEGORY=libraries
inherit cmake kde.org

DESCRIPTION="Tools for accessing and converting various ebook file formats"
HOMEPAGE="https://invent.kde.org/libraries/ebook-tools
	https://sourceforge.net/projects/ebook-tools/"

if [[ ${KDE_BUILD_TYPE} != live ]]; then
	SRC_URI="https://downloads.sourceforge.net/${PN}/${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~ppc ~ppc64 ~riscv ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+lit2epub"

DEPEND="
	dev-libs/libxml2:=
	>=dev-libs/libzip-1.7.2:=
"
RDEPEND="${DEPEND}
	lit2epub? ( app-text/convertlit )
"

src_prepare() {
	cmake_src_prepare
	use lit2epub || sed -e "\|lit2epub|d" -i src/tools/CMakeLists.txt || die
}
