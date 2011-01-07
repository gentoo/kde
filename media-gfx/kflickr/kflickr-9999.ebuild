# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_LINGUAS="ar bg ca cs de es eu fr he hu id it ko ku lv nb nds nl pl pt_BR
	ru sl sr sv tr uk zh_CN"

KDE_LINGUAS_DIR="${S}/src/po"

inherit kde4-base

DESCRIPTION="KDE App for easy upload of your favourite photos to your Flickr.com account"
HOMEPAGE="http://kflickr.sourceforge.net/"
ESVN_REPO_URI="https://kflickr.svn.sourceforge.net/svnroot/kflickr/trunk/kflickr"
ESVN_PROJECT="kflickr"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"
