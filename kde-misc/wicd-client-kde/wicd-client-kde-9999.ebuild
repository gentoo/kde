# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
KDE_LINGUAS_DIR="translations"
KDE_LINGUAS="cs es fr hu it pt_BR zh_CN"
inherit git kde4-base

DESCRIPTION="Wicd client build on the KDE Development Platform"
HOMEPAGE="http://kde-apps.org/content/show.php/Wicd+Client+KDE?content=132366"
EGIT_REPO_URI="git://gitorious.org/${PN}/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="net-misc/wicd"
DEPEND="${RDEPEND}"

src_unpack() {
	git_src_unpack
}
