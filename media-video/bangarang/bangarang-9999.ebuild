# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

KDE_LINGUAS="cs de fr it nl pl pt_BR zh_CN"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="A media player for KDE utilizing Nepomuk for tagging"
HOMEPAGE="http://bangarangkde.wordpress.com"
EGIT_REPO_URI="git://gitorious.org/bangarang/bangarang.git"

LICENSE="GPL-3"
KEYWORDS=""
SLOT="4"
IUSE="debug"

RDEPEND="
	>=kde-base/kdelibs-${KDE_MINIMAL}[semantic-desktop]
	media-libs/taglib
	media-sound/phonon
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"
