# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit kde4-base

DESCRIPTION="A small IDE taylored for development of Plasma components, such as Widgets, Runners, Dataengines."
HOMEPAGE="https://projects.kde.org/projects/kdereview/plasmate"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="
	>=dev-libs/libattica-0.1.4
	app-crypt/gpgme
	$(add_kdebase_dep knewstuff)
"

RDEPEND="
	dev-vcs/git
	${DEPEND}
"
