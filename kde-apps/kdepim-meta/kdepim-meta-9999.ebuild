# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit kde5-meta-pkg

DESCRIPTION="KDE PIM - merge this to pull in all kdepim-derived packages"
HOMEPAGE="http://www.kde.org/applications/development"
KEYWORDS=""
IUSE="cvs"

RDEPEND="
	$(add_kdeapps_dep akonadi)
	$(add_kdeapps_dep akonadi-calendar)
	$(add_kdeapps_dep akonadi-search)
	$(add_kdeapps_dep gpgmepp)
	$(add_kdeapps_dep kalarmcal)
	$(add_kdeapps_dep kblog)
	$(add_kdeapps_dep kcalcore)
	$(add_kdeapps_dep kcalutils)
	$(add_kdeapps_dep kcontacts)
	$(add_kdeapps_dep kdepim)
	$(add_kdeapps_dep kdepim-runtime)
	$(add_kdeapps_dep kdepimlibs)
	$(add_kdeapps_dep kholidays)
	$(add_kdeapps_dep kidentitymanagement)
	$(add_kdeapps_dep kimap)
	$(add_kdeapps_dep kldap)
	$(add_kdeapps_dep kmailtransport)
	$(add_kdeapps_dep kmbox)
	$(add_kdeapps_dep kmime)
	$(add_kdeapps_dep kontactinterface)
	$(add_kdeapps_dep kpimtextedit)
	$(add_kdeapps_dep ktnef)
	$(add_kdeapps_dep syndication)
"
