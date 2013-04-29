# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDEBASE="kdevelop"
KMNAME="kdev-mercurial"
KDEVPLATFORM_VERSION="1.0.2"
inherit kde4-base

DESCRIPTION="Mercurial plugin for KDevelop 4"
HOMEPAGE="http://websvn.kde.org/trunk/playground/devtools/kdevelop4-extra-plugins/mercurial/"
EGIT_REPO_URI="git://anongit.kde.org/kdev-mercurial"
#svn://anonsvn.kde.org/home/kde/trunk/playground/devtools/kdevelop4-extra-plugins/mercurial/"

LICENSE="GPL-3"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	dev-vcs/mercurial
"
