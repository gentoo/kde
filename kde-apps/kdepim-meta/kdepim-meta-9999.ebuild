# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit kde5-meta-pkg

DESCRIPTION="KDE PIM - merge this to pull in all kdepim-derived packages"
HOMEPAGE="https://www.kde.org/applications/development"
KEYWORDS=""
IUSE="cvs nls"

[[ ${KDE_BUILD_TYPE} = live ]] && L10N_MINIMAL=${KDE_APPS_MINIMAL}

RDEPEND="
	$(add_kdeapps_dep akonadi)
	$(add_kdeapps_dep akonadi-calendar)
	$(add_kdeapps_dep akonadi-contact)
	$(add_kdeapps_dep akonadi-mime)
	$(add_kdeapps_dep akonadi-notes)
	$(add_kdeapps_dep akonadi-search)
	$(add_kdeapps_dep akonadi-socialutils)
	$(add_kdeapps_dep calendarsupport)
	$(add_kdeapps_dep eventviews)
	$(add_kdeapps_dep gpgmepp)
	$(add_kdeapps_dep grantleetheme)
	$(add_kdeapps_dep incidenceeditor)
	$(add_kdeapps_dep kalarmcal)
	$(add_kdeapps_dep kblog)
	$(add_kdeapps_dep kcalcore)
	$(add_kdeapps_dep kcalutils)
	$(add_kdeapps_dep kcontacts)
	$(add_kdeapps_dep kdepim)
	$(add_kdeapps_dep kdepim-apps-lib)
	$(add_kdeapps_dep kdepim-kioslaves)
	$(add_kdeapps_dep kdepim-runtime)
	$(add_kdeapps_dep kdgantt2)
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
	$(add_kdeapps_dep libakonadi)
	$(add_kdeapps_dep libgravatar)
	$(add_kdeapps_dep libkdepim)
	$(add_kdeapps_dep libkleo)
	$(add_kdeapps_dep libksieve)
	$(add_kdeapps_dep mailcommon)
	$(add_kdeapps_dep mailimporter)
	$(add_kdeapps_dep messagecomposer)
	$(add_kdeapps_dep messagecore)
	$(add_kdeapps_dep messagelist)
	$(add_kdeapps_dep messageviewer)
	$(add_kdeapps_dep pimcommon)
	$(add_kdeapps_dep syndication)
	$(add_kdeapps_dep templateparser)
	nls? (
		$(add_kdeapps_dep kdepim-l10n '' ${L10N_MINIMAL})
	)
"
