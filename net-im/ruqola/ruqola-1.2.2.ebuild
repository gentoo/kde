# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit ecm

DESCRIPTION="Ruqola is a Rocket.Chat client for the KDE desktop."
HOMEPAGE="https://github.com/KDE/ruqola"

if [ "${PV}" = "9999" ]; then
	EGIT_REPO_URI="https://github.com/KDE/${PN}.git"
	inherit git-r3
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/KDE/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE=""
SLOT="0"
IUSE="keyring telemetry"

DEPEND="dev-qt/qtwebsockets[ssl]
	dev-qt/qtgui
	dev-qt/qtwidgets
	dev-qt/qtnetworkauth
	dev-qt/qttest
	dev-qt/qtmultimedia[widgets]
	kde-frameworks/kcoreaddons
	kde-frameworks/ki18n
	kde-frameworks/kcrash
	kde-frameworks/knotifications
	kde-frameworks/kiconthemes
	kde-frameworks/syntax-highlighting
	kde-frameworks/kdoctools
	kde-frameworks/kdbusaddons
	kde-frameworks/kxmlgui
	kde-frameworks/kio
	kde-frameworks/sonnet
	kde-frameworks/ktextwidgets
	kde-frameworks/knotifyconfig
	keyring? ( dev-libs/qtkeychain )
	telemetry? ( dev-libs/kuserfeedback )"
RDEPEND="${DEPEND}"
BDEPEND=""
