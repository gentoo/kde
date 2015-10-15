# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_DOXYGEN="true"
KDE_TEST="true"
inherit kde5

DESCRIPTION="Library for accessing MBox format mail storages"
LICENSE="LGPL-2+"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="$(add_kdeapps_dep kmime)"
DEPEND="${RDEPEND}"
