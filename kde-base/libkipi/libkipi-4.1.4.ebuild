# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkipi/libkipi-4.1.3.ebuild,v 1.2 2008/11/16 08:18:48 vapier Exp $

EAPI="2"

KMNAME="kdegraphics"
KMMODULE=libs/libkipi

inherit kde4-meta

DESCRIPTION="A library for image plugins accross KDE applications"
HOMEPAGE="http://www.kipi-plugins.org/"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="!<=media-libs/libkipi-0.1.6"
RDEPEND="${DEPEND}"
