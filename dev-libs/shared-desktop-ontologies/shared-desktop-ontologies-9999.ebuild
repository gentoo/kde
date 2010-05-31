# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/shared-desktop-ontologies/shared-desktop-ontologies-0.3.ebuild,v 1.1 2010/03/11 04:28:21 reavertm Exp $

EAPI="2"

inherit cmake-utils subversion

DESCRIPTION="Shared OSCAF desktop ontologies"
HOMEPAGE="http://sourceforge.net/projects/oscaf"
ESVN_REPO_URI="https://oscaf.svn.sourceforge.net/svnroot/oscaf/trunk/ontologies"

LICENSE="BSD CCPL-Attribution-3.0"
SLOT="0"
KEYWORDS=""
IUSE=""

DOCS=(AUTHORS ChangeLog README)
