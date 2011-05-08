# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/bangarang/bangarang-2.0.ebuild,v 1.2 2011/03/26 16:31:52 dilfridge Exp $

EAPI=3

KDE_MINIMAL="4.5"
KDE_LINGUAS="cs da de es fi fr it lt nl pl pt_BR uk zh_CN"
KDE_SCM="git"
EGIT_REPO_URI="git://gitorious.org/bangarang/bangarang.git"
inherit kde4-base

DESCRIPTION="Media player for KDE utilizing Nepomuk for tagging"
HOMEPAGE="http://bangarangkde.wordpress.com"
[[ ${PV} == 9999 ]] || SRC_URI="http://opendesktop.org/CONTENT/content-files/113305-${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS=""
SLOT="4"
IUSE="debug"

RDEPEND="
	dev-libs/soprano
	$(add_kdebase_dep kdelibs 'semantic-desktop')
	$(add_kdebase_dep nepomuk)
	$(add_kdebase_dep kdemultimedia-kioslaves)
	media-libs/taglib
	media-libs/phonon
	x11-libs/qt-script
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"

S=${WORKDIR}/bangarang-bangarang
