# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit kde5-meta-pkg

DESCRIPTION="Meta package for the KDE Applications collection"
KEYWORDS=""
IUSE="accessibility +qt4 nls pim sdk"

[[ ${KDE_BUILD_TYPE} = live ]] && L10N_MINIMAL=${KDE_APPS_MINIMAL}

RDEPEND="
	$(add_kdeapps_dep kate)
	$(add_kdeapps_dep kdeadmin-meta 'qt4?')
	$(add_kdeapps_dep kdecore-meta 'qt4?')
	$(add_kdeapps_dep kdeedu-meta 'qt4?')
	$(add_kdeapps_dep kdegames-meta 'qt4?')
	$(add_kdeapps_dep kdegraphics-meta 'qt4?')
	$(add_kdeapps_dep kdemultimedia-meta 'qt4?')
	$(add_kdeapps_dep kdenetwork-meta 'qt4?')
	$(add_kdeapps_dep kdeutils-meta 'qt4?')
	nls? ( $(add_kdeapps_dep kde-l10n '' ${L10N_MINIMAL}) )
	pim? ( $(add_kdeapps_dep kdepim-meta) )
	qt4? (
		accessibility? ( $(add_kdeapps_dep kdeaccessibility-meta '' 15.12.3) )
		nls? ( $(add_kdeapps_dep kde4-l10n 'minimal' ${L10N_MINIMAL}) )
		sdk? ( $(add_kdeapps_dep kdewebdev-meta '' 15.08.3) )
	)
	sdk? ( $(add_kdeapps_dep kdesdk-meta 'qt4?') )
"
