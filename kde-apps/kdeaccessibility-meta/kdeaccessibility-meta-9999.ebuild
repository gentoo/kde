# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="kdeaccessibility - merge this to pull in all kdeaccessiblity-derived packages"
HOMEPAGE="https://apps.kde.org/"

LICENSE="metapackage"
SLOT="5"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=app-accessibility/kontrast-${PV}:*
	>=kde-apps/kmag-${PV}:*
	>=kde-apps/kmousetool-${PV}:*
	>=kde-apps/kmouth-${PV}:*
"
