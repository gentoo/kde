# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_LINGUAS="af ar be bg br bs ca ca@valencia cs cy da de el en_GB eo es et eu fa fi fr ga gl hi hne hr is it ja kk km lt lv mai mk ms nb nds ne nl nn oc pa pl pt_BR pt ro ru se sk sl sr@ijekavianlatin sr@ijekavian sr@Latn sr sv ta tg th tr ug uk xh zh_CN zh_HK zh_TW"
inherit kde4-base

DESCRIPTION="KDE CD ripper and audio encoder frontend"
HOMEPAGE="http://kde-apps.org/content/show.php?content=107645"
KEYWORDS=""

LICENSE="GPL-2 FDL-1.2"
SLOT="4"
IUSE="debug"

COMMON_DEPEND="
	$(add_kdeapps_dep libkcddb)
	$(add_kdeapps_dep libkcompactdisc)
	media-libs/libdiscid
	>=media-libs/taglib-1.5
"

RDEPEND="${COMMON_DEPEND}
	$(add_kdebase_dep kdelibs 'udev,udisks(+)')
	$(add_kdeapps_dep audiocd-kio)
"

DEPEND="${COMMON_DEPEND}"

DOCS=( Changelog TODO )
