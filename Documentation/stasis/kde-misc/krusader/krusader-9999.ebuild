# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="svn"
SLOT="kde-svn"
inherit kde4svn eutils

PREFIX="${KDEDIR}"

ESVN_REPO_URI="http://krusader.svn.sourceforge.net/svnroot/krusader/trunk/krusader_kde4"
DESCRIPTION="An advanced twin-panel (commander-style) file-manager for KDE with many extras."
HOMEPAGE="http://www.krusader.org"
LICENSE="GPL-2"

KEYWORDS=""
IUSE=""

DEPEND="sys-devel/gettext"
