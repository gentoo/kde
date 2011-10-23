# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

# KDE_LINGUAS="bg cs da de el en_GB eo es et fi fr ga gl hu it km lt ms nb nds nl
# pa pt pt_BR ro ru sk sr sr@ijekavian sr@ijekavianlatin sr@latin sv tg th tr uk
# zh_CN zh_TW"

WEBKIT_REQUIRED="always"
inherit kde4-base

DESCRIPTION="A WebKit KPart for konqueror"
HOMEPAGE="http://opendesktop.org/content/show.php?content=127960"
# SRC_URI="http://opendesktop.org/CONTENT/content-files/127960-${P}.tar.bz2"
SRC_URI="http://dev.gentoo.org/~thev00d00/distfiles/${CATEGORY}/${P}.tar.xz"

LICENSE="LGPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
SLOT="4"
IUSE="debug"
