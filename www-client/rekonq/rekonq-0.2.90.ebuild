# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://gitorious.org/rekonq/mainline.git"
	GIT_ECLASS="git"
	KEYWORDS=""
else
	SRC_URI="mirror://sourceforge/rekonq/rekonq-${S}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

WEBKIT_REQUIRED="always"
inherit kde4-base ${GIT_ECLASS}

unset GIT_ECLASS

DESCRIPTION="Konqueror replacement using webkit as backend."
HOMEPAGE="http://rekonq.sourceforge.net/"

LICENSE="GPL-2"
SLOT="4"
IUSE="debug"
