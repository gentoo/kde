# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdevelop"
KDEVPLATFORM_VERSION="1.0.2"
inherit subversion kde4-base

DESCRIPTION="Mercurial plugin for KDevelop 4"
HOMEPAGE="http://websvn.kde.org/trunk/playground/devtools/kdevelop4-extra-plugins/mercurial/"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/playground/devtools/kdevelop4-extra-plugins/mercurial/"

LICENSE="GPL-3"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	dev-vcs/mercurial
"

src_unpack() {
	subversion_src_unpack
}
