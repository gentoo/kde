# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/rekonq/rekonq-0.8.1.ebuild,v 1.4 2012/02/03 15:23:26 dilfridge Exp $

EAPI=4

WEBKIT_REQUIRED="always"
QT_MINIMAL="4.8"
KDE_MINIMAL="4.7"
KDE_SCM="git"

KDE_LINGUAS="bs ca@valencia da el eo et fa fr gl is ja lt nds pl pt_BR ru sl sr@ijekavian sr@latin th ug zh_CN
bg ca cs de en_GB es eu fi ga hu it ko nb nl pt ro sk sr sr@ijekavianlatin sv tr uk zh_TW"

KDE_DOC_DIRS="doc"
KDE_HANDBOOK="optional"
VIRTUALX_REQUIRED=test
inherit kde4-base

DESCRIPTION="A browser based on qt-webkit"
HOMEPAGE="http://rekonq.kde.org/"
[[ ${PV} != *9999* ]] && SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	>=x11-libs/qt-xmlpatterns-${QT_MINIMAL}
"
RDEPEND="${DEPEND}"

# All test fails
RESTRICT="test"
