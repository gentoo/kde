# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="A KDE4 follow-up to Baghira KDE Theme Engine, which resembles Mac OS X"
HOMEPAGE="http://cloudcity.sourceforge.net/"
ESVN_REPO_URI="https://cloudcity.svn.sourceforge.net/svnroot/cloudcity"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="live"
IUSE="debug plasma"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_enable plasma XBAR)"

	kde4-base_src_configure
}
