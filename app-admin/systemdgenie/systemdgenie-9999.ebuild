# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm kde.org

if [[ ${KDE_BUILD_TYPE} = release ]]; then
	SRC_URI="mirror://kde/unstable/${PN}/${P}.tar.xz"
	KEYWORDS="~amd64 ~ppc64"
fi

DESCRIPTION="Systemd managment utility"
HOMEPAGE="https://invent.kde.org/system/systemdgenie"

LICENSE="GPL-2+"
SLOT="5"

BDEPEND="sys-devel/gettext"
DEPEND="
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	kde-frameworks/kauth:5
	kde-frameworks/kconfigwidgets:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/kcrash:5
	kde-frameworks/ki18n:5
	kde-frameworks/kwidgetsaddons:5
	kde-frameworks/kxmlgui:5
	sys-apps/systemd:=
"
RDEPEND="${DEPEND}"
