# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_QTHELP="false" # TODO: Port to ECMGenerateQDoc
KFMIN=6.31.0
QTMIN=6.11.2
inherit ecm gear.kde.org

DESCRIPTION="Wrapper around exiv2 library"

LICENSE="GPL-2+"
SLOT="6"
KEYWORDS=""
IUSE="+xmp"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui]
	>=media-gfx/exiv2-0.27:=[xmp=]
"
RDEPEND="${DEPEND}"

src_prepare() {
	# TODO: Avoid automagic qttools[qdoc] dep
	sed -i -e '/include(ECMGenerateQDoc)/d' CMakeLists.txt || die
	sed -i -e '/ecm_generate_qdoc/d' src/CMakeLists.txt || die

	ecm_src_prepare
}
