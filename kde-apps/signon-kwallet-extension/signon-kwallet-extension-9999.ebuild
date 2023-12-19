# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=5.106.0
inherit ecm gear.kde.org

DESCRIPTION="KWallet extension for signond"
HOMEPAGE="https://accounts-sso.gitlab.io/"

LICENSE="GPL-2+"
SLOT="5"
KEYWORDS=""

DEPEND="
	>=kde-frameworks/kwallet-${KFMIN}:5
	>=net-libs/signond-8.61-r1[qt5(-)]
"
RDEPEND="${DEPEND}"
