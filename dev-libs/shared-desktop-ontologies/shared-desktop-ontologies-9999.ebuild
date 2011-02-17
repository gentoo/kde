# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit cmake-utils git

DESCRIPTION="Shared OSCAF desktop ontologies"
HOMEPAGE="http://sourceforge.net/projects/oscaf"
EGIT_REPO_URI="git://oscaf.git.sourceforge.net/gitroot/oscaf/shared-desktop-ontologies"

LICENSE="|| ( BSD CCPL-Attribution-ShareAlike-3.0 )"
SLOT="0"
KEYWORDS=""
IUSE=""

DOCS=(AUTHORS ChangeLog README)
