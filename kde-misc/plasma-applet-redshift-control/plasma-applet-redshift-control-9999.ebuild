# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit kde5

EGIT_REPO_URI="https://github.com/kotelnik/${PN}.git"

DESCRIPTION="Plasma 5 applet for controlling redshift"
HOMEPAGE="http://kde-apps.org/content/show.php/Redshift+Control?content=170746 https://github.com/kotelnik/plasma-applet-redshift-control/"

LICENSE="GPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="x11-misc/redshift"
