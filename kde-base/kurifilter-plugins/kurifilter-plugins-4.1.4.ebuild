# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kurifilter-plugins/kurifilter-plugins-4.1.3.ebuild,v 1.2 2008/11/16 08:12:45 vapier Exp $

EAPI="2"

KMNAME=kdebase-runtime
inherit kde4-meta

DESCRIPTION="KDE: Plugins to manage filtering URIs."
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

# Tests segfault. Last checked on 4.0.3.
RESTRICT="test"
