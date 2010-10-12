# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/rekonq/rekonq-0.5.0-r1.ebuild,v 1.2 2010/10/12 18:20:48 tampakrap Exp $

EAPI=3

WEBKIT_REQUIRED=always
QT_MINIMAL="4.7"
KDE_MINIMAL="4.5"

if [[ ${PV} != *9999* ]]; then
	KDE_LINGUAS_DIR="i18n"
	KDE_LINGUAS="ca cs da de el en_GB es et fr hu it ja ko lt nb
	nds nl pt_BR pt ru sl sr sv uk zh_CN"
	KDE_DOC_DIRS="docs"
	KDE_HANDBOOK="optional"
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
else
	EGIT_REPO_URI="git://git.kde.org/rekonq.git"
	GIT_ECLASS="git"
fi

inherit kde4-base ${GIT_ECLASS}

unset GIT_ECLASS

DESCRIPTION="A browser based on qt-webkit"
HOMEPAGE="http://rekonq.sourceforge.net/"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	>=x11-libs/qt-xmlpatterns-${QT_MINIMAL}
"
RDEPEND="${DEPEND}"

RESTRICT="test"

PATCHES=( "${FILESDIR}/${P}-cve-2010-2536.patch" )
