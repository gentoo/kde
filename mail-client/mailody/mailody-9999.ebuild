# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
IUSE=""
SLOT="kde-svn"
NEED_KDE=":${SLOT}"
KMNAME="extragear/pim"
inherit kde4svn-meta

DESCRIPTION="A Qt/KDE based mail client based on Akonadi."
HOMEPAGE="http://www.kde-apps.org/content/show.php/Mailody?content=47793"

SLOT="kde-svn"
LICENSE="GPL-2"

DEPEND="kde-base/kdelibs:${SLOT}
	kde-base/kdepimlibs:${SLOT}
	kde-base/marble:${SLOT}
	kde-base/nepomuk:${SLOT}"
