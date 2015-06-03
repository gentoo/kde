# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kdegraphics-thumbnailers"
EGIT_BRANCH="frameworks"
inherit kde5 git-r3

DESCRIPTION="Thumbnail generators for PDF/PS and RAW files"
KEYWORDS=" ~amd64 ~x86"
IUSE=""

EGIT_REPO_URI="git://anongit.kde.org/${KMNAME}"
EGIT_COMMIT="fa9e70cd5950e36608211507f53f8bd1d12e074f"
SRC_URI=""

DEPEND="
	>=kde-apps/libkdcraw-15.04.50_pre20150515:5
	>=kde-apps/libkexiv2-15.04.50_pre20150515:5
	$(add_frameworks_dep kio)
	dev-qt/qtgui:5
"

RDEPEND="${DEPEND}"

if [[ ${KDE_BUILD_TYPE} != live ]]; then
	S="${WORKDIR}/${P}"
fi

src_unpack() {
	git-r3_src_unpack
}
