# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_LINGUAS="cs da de el es fi fr hu it lt nl pl pt pt_BR ru uk zh_CN"
inherit kde4-base

DESCRIPTION="Media player for KDE utilizing Nepomuk for tagging"
HOMEPAGE="http://bangarangkde.wordpress.com"
EGIT_REPO_URI="git://anongit.kde.org/bangarang"
[[ ${PV} == 9999 ]] || SRC_URI="http://opendesktop.org/CONTENT/content-files/113305-${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS=""
SLOT="4"
IUSE="debug"

RDEPEND="
	dev-libs/soprano
	$(add_kdebase_dep kdelibs 'nepomuk')
	$(add_kdebase_dep nepomuk)
	$(add_kdebase_dep audiocd-kio)
	media-libs/taglib
	media-libs/phonon[qt4]
	dev-qt/qtscript:4
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"

S=${WORKDIR}/bangarang-bangarang
