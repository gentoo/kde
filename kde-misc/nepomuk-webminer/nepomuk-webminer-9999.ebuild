# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
KDE_HANDBOOK="optional"
KDE_MINIMAL="4.10"
KMNAME="nepomuk-webminer"
PYTHON_COMPAT=( python2_7 )

inherit python-single-r1 kde4-base

DESCRIPTION="Python plugin enabled web harvester for additional metadata for the Nepomuk database"
HOMEPAGE="http://docs-staging.kde.org/development/en/extragear-base/nepomuk-webminer/"
KEYWORDS=""
SLOT="4"
LICENSE="GPL-2"
IUSE="debug"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	dev-libs/libxml2
	dev-libs/libxslt
	${PYTHON_DEPEND}
	$(add_kdebase_dep pykde4 "${PYTHON_USEDEP}")
"
RDEPEND="${DEPEND}"

pkg_setup() {
	python-single-r1_pkg_setup
	kde4-base_pkg_setup
}
