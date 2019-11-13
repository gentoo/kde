# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_TEST="forceoptional"
inherit ecm kde.org

DESCRIPTION="C++ library for controlling asynchronous tasks"

LICENSE="LGPL-2+"
SLOT="5"
[[ ${KDE_BUILD_TYPE} = release ]] && KEYWORDS="~amd64"
IUSE=""
