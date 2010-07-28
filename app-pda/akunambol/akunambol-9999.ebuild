# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=2

inherit kde4-base git

DESCRIPTION="Akonadi Syncml client"
HOMEPAGE="http://gitorious.org/akunambol"
EGIT_REPO_URI="git://gitorious.org/akunambol/akunambol.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	app-office/akonadi-server
	>=app-pda/funambol-client-sdk-9999
	>=kde-base/kdelibs-${KDE_MINIMAL}
	>=kde-base/kdepimlibs-${KDE_MINIMAL}
"
RDEPEND="${DEPEND}"
