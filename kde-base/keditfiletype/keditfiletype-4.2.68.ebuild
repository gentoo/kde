# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="KDE mime/file type assocciation editor"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

# @Since 4.2.68 - split from konqueror
RDEPEND="
	!kdeprefix? ( !<=kde-base/konqueror-4.2.67[-kdeprefix] )
	kdeprefix? ( !<=kde-base/konqueror-4.2.67:4.3 )
"
